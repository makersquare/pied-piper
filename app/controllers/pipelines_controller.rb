class PipelinesController < ApplicationController
  respond_to :json

  def show
    Pipeline.find(pipeline_params)
    #TSX cause we need the pipeline data, we need the stage data, boxes
    respond_with 
  end

  #Retrieves all rows from the Pipeline table, ID, name
  def index 
    respond_with Pipeline.all
  end

  def new
    # Displays form for creating a new pipeline
  end

  def create
    # TSX to check and make sure valid, probably do that on the front end? Backend check for if
    # people concurrently add pipelines
    Pipeline.create()
  end

  def destroy
    # TSX to check if pipeline is in trash and actually deletes db entry
    # also need to destroy all associated stages and boxes associated
    # destroy the entries in the pipeline users table
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
