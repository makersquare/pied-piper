class ContactsController < ApplicationController
  respond_to :json, :html
  # before_filter :logged_in?
  # before_filter :admin?

  def create
    # Create a new contact manually with the create_contact TXS
    results = CreateContact.run(contact_params)
    if results.success?
      respond_with results.contact
    else
      respond_with results.error
    end
  end

  def show
    # Show a contact within its box given the contact id
    show_contact = GetContactBox.run(params)
    respond_with show_contact
  end

  def index
    # Index to show boxes and create new boxes
    respond_with Box.all.to_json
  end

  def update
    # User can create new box fields
    respond_with Field.create(params)
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

  def contacts_params
    # All params currently permitted
    params.permit(:id, :name, :email, :phoneNum, :city)
  end
end
