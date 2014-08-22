class StagesController < ApplicationController
respond_to :json, :html
  # before_filter :logged_in?
  # before_filter :admin?
  def new
  end

  def create
    # Create a new stage for a pipeline
    results = CreateStage.run(stage_params)
    if results.success?
      respond_with results.pipeline, results.data
    else
      respond_with results.error
    end
  end

  def index
    # Show stages for a given pipeline
    respond_with Stage.where(pipeline_id: params['pipeline_id']).to_json
  end

  def destroy
    # Destroy a pipeline in browser and database
    # Move any contacts associated with that stage to the default stage
    results = DestroyStage.run(stage_params)
    binding.pry
    if results.success?
      respond_with results.contact_boxes
    else
      respond_with results.error
    end
  end

  private

  def stage_params
    params.permit(:id, :name, :description, :pipeline_id, :format)
  end
end
