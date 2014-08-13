class ContactsController < ApplicationController
  respond_to :json, :html
  # before_filter :logged_in?
  # before_filter :admin?
  def new
  end

  def create
    # Create a new contact manually with the create_contact TXS
    results = CreateContact.run(contact_params)
    @result_box = CreateBox.run({:contact_id=>results.contact.id})
    if results.success?
      respond_with results.contact
    else
      respond_with results.error
    end
  end

  def show
    # Show a contact within its box given the contact id
    show_contact = GetContactBox.run({:contact_id=>contact_params[:id]})
    if show_contact.success?
      respond_with show_contact.to_h
    elsif show_contact.error == :no_box_found
      respond_with({errors: ["Could not find proper Box"]}, status: :unprocessable_entity)
    end
  end

  def index
    # Index to show contacts
    result = RetrieveAllContactInfo.run(params)
    if result.success?
      respond_with result.contacts.map(&:to_h)
    else
      respond_with(result.error, status: :unprocessable_entity)
    end
  end

  def update
    # User can update a contact's info and associated box info
    update_contact_box = UpdateContactBox.run(box_params)
    respond_with update_contact_box
  end

  private

  def box_params
    # All params currently permitted
    params.permit(:id, :contact_id, :pipeline_id, :pipeline_name, :format, :cid, :pid, :success?,
                  :city, :stage_id,
                  :box=>[:id, :pipeline_id, :stage_id, :pipeline_location],
                  :stage=>[:id, :name, :description, :pipeline_id, :pipeline_location],
                  :notes=>[:notes, :id, :box_id, :user_id],
                  :box_fields=>[:value, :field_id, :id, :box_id, :pipeline_id],
                  :field_values=>[:value, :field_id, :id, :box_id, :pipeline_id],
                  :fields=>[:field_name, :id, :pipeline_id, :field_type],
                  :contact=>[:name, :phonenumber, :contact_id, :city, :id, :email, :stage_id])
  end

  def contact_params
    params.require(:contact).permit(:name, :phonenumber)
  end

  def contact_params
    params.permit(:id, :name, :email, :phonenumber, :city, :stage_id)
  end

  # def field_params
  #   params.permit(:id, :pipeline_id, :type, :field_name)
  # end

  # def box_field_params
  #   params.permit(:id, :field_id, :box_id, :value)
  # end
end
