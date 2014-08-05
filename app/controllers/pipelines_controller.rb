class PipelinesController < ApplicationController
  respond_to :json
  # before_filter :logged_in?
  # before_filter :admin?, :only => [:destroy, :trash]

  #Retrieves all rows from the Pipeline table, ID, name. 
  #Use this for the sidebar
  def index 
    respond_with Pipeline.all
  end

  # TSX to check and make sure valid. Backend check for if
  # people concurrently add pipelines
  def create
    respond_with CreatePipeline.run(pipeline_params)
  end

  #sets DB flag for pipeline to be trashed, can limit to admins on frontend
  def trash_pipeline
    Pipeline.update(params[:id], trashed: true)
  end

  #Changes the name of the pipeline
  def update
    respond_with UpdatePipelineName.run(pipeline_params)
  end

#TODOS!!!!!

  #TSX cause we need the pipeline data, we need the stage data, boxes. Jbuilder, rabl
  #Ar serializer
  def show
    pipeline_with_data = RetrievePipeline.run(params[:id])
    respond_with pipeline_with_data
  end

  # TSX to check if pipeline is in trash and actually deletes db entry
  # also need to destroy all associated stages and boxes associated
  # destroy the entries in the pipeline users table
  def destroy

  end

  def retrieve_pipelines_with_stages
  end

  private

  def pipeline_params
    params.permit(:id, :name, :trashed)
  end
end