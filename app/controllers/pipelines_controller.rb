class PipelinesController < ApplicationController
  respond_to :json

  #TSX cause we need the pipeline data, we need the stage data, boxes
  def show 
    Pipeline.find(pipeline_params)
    respond_with 
  end

  #Retrieves all rows from the Pipeline table, ID, name
  def index 
    respond_with Pipeline.all
  end

  # Displays form for creating a new pipeline, might not be needed
  def new
  end

  # TSX to check and make sure valid. Backend check for if
  # people concurrently add pipelines
  def create
    respond_with CreatePipeline.run(pipeline_params)
  end

  # TSX to check if pipeline is in trash and actually deletes db entry
  # also need to destroy all associated stages and boxes associated
  # destroy the entries in the pipeline users table
  def destroy
    
  end

  #sets DB flag for pipeline to be trashed, can limit to admins on frontend
  def trash_pipeline
    Pipeline.update(params[:id], trashed: true)
  end

  #Changes the name of the pipeline
  def update
    respond_with UpdatePipelineName.run(pipeline_params)
  end

  private

  def pipeline_params
    params.permit(:id, :name)
  end
end
