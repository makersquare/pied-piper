class ContactsController < ApplicationController
  respond_to :json, :html
  # before_filter :logged_in?
  # before_filter :admin?

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
    respond_with show_contact
  end

  def index
    # Index to show contacts
    respond_with Contact.all.to_json
  end

  def update
    # User can update a contact's info and associated box info
    # binding.pry
    update_contact_box = UpdateContactBox.run(params)
    respond_with update_contact_box
  end

  private

  def box_params
    # All params currently permitted
    params.permit(:id, :contact_id, :pipeline_id, :stage_id, :pipeline_location)
  end

  def field_params
    # All params currently permitted
    params.permit(:id, :pipeline_id, :type, :field_name)
  end

  def box_field_params
    # All params currently permitted
    params.permit(:id, :field_id, :box_id, :value)
  end

  def contact_params
    # All params currently permitted
    params.permit(:id, :name, :email, :phoneNum, :city)
  end
end
