class PipelinesController < ApplicationController
  respond_to :json
  # before_filter :logged_in?
  # before_filter :admin?, :only => [:destroy, :trash]
  # We need to check and make sure the request is coming from
  # an admin of the pipeline

  #Retrieves all rows from the Pipeline table, ID, name
  def index 
    respond_with Pipeline.all
  end

  # TSX to check and make sure valid. Backend check for if
  # people concurrently add pipelines. This needs to check
  # if the request is coming for an admin of the entire app or
  # allow any user to create pipelines
  def create
    respond_with CreatePipeline.run(pipeline_params).data
  end

  #sets DB flag for pipeline to be trashed, can limit to admins on frontend
  def trash_pipeline
    Pipeline.update(params[:id], trashed: true)
  end

  #Changes the name of the pipeline
  def update
    respond_with UpdatePipelineName.run(pipeline_params).data
  end

  #TSX cause we need the pipeline data, we need the stage data, boxes. Jbuilder, rabl
  #Ar serializer
  def show
    pipeline_with_data = RetrievePipeline.run(params[:id])
    respond_with pipeline_with_data.data
  end

  # TSX to check if pipeline is in trash and actually deletes db entry
  # also need to destroy all associated stages and boxes associated
  # destroy the entries in the pipeline users table
  def destroy
    result = DestroyPipeline.run(params[:id])
    if result.success?
      respond_with result.data
    else #Do something else saying that the pipeline was not trashed
      respond_with result.error.to_json
    end
  end

  def add_to_pipeline
    
  end

  def remove_from_pipeline

  end

  def update_access_to_pipeline

  end

  private

  def pipeline_params
    params.permit(:id, :name, :trashed)
  end
end
