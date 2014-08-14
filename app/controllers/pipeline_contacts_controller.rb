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

  def destroy
    Contact.find(contact_params[:id]).boxes.find_by(pipeline_id: box_params[:pipeline_id]).destroy
  end



  private

  def box_params
    params.permit(:id, :contact_id, :stage_id, :pipeline_id)
  end

  def contact_params
    params.permit(:id, :contact_id, :name, :email, :phonenumber, :city)
  end
end
