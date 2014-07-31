class PipelinesController < ApplicationController
  respond_to :json

  def show
    Pipeline.find()
    #TSX cause we need the pipeline data, we need the stage data, contacts
    respond_with 
  end

  def index #Sidepanel 
    respond_with Pipeline.all
  end

  def new
    #Displays form for creating a new pipeline, on the web app this will probably incude
    # a call to make stages for the pipeline as well
    # 
  end

  def create
    #TSX to check and make sure valid, probably do that on the front end? Backend check for if
    # people concurrently add pipelines
    Pipeline.create()
  end

  def destroy
    # TSX to check if pipeline is in trash and actually deletes db entry

  end

  def trash_pipeline
    #sets DB flag for pipeline to be trashed
  end

  def update
    #
  end

  def update_pipeline_users
    
  end

  private

  def pipeline_params
    params.permit()
  end
end
