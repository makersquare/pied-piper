class PipelineContactsController < ApplicationController
  respond_to :json, :html

  def index
    # Index for all contacts
    result = RetrieveBoxesForPipeline.run({pipeline_id: params[:pipeline_id]})

    if result.success?
      respond_with result.contacts.map(&:to_h)
    else
      respond_with(result.error, status: :unprocessable_entity)
    end
  end

  def create
    # Finds the first stage in a given pipeline
    first_stage_in_pipeline = Pipeline.find(params[:pipeline_id]).stages.order(:pipeline_location).first
    # Creates a box with all the required parameters
    result = CreateBox.run(contact_id: contact_params[:contact_id], stage_id: first_stage_in_pipeline.id, pipeline_id: box_params[:pipeline_id], pipeline_location: first_stage_in_pipeline.pipeline_location)
    if result.success?
      respond_with result.box
    else
      respond_with result.error
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


  def update
    # User can update a contact's info and associated box info
    update_contact_box = UpdateContactBox.run(box_params)
    respond_with update_contact_box
  end

  def destroy
    Contact.find(contact_params[:id]).boxes.find_by(pipeline_id: box_params[:pipeline_id]).destroy
  end

  private

  def box_params
    res = params.permit(:id, :contact_id, :stage_id, :pipeline_id,
      :pipeline_location, :contact=>[:name, :phonenumber, :city, :email] )
    res[:contact_id] ||= params[:id]
    res
  end

  def contact_params
    params.permit(:id, :contact_id, :name, :email, :phonenumber, :city)
  end
end
