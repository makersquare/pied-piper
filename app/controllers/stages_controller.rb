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
      respond_with results.data
    else
      respond_with results.error
    end
  end

  def index
    # Show stages for a given pipeline
    respond_with Status.where(pipeline_id: params['pipeline_id']).to_json
  end

  def destroy
    # Destroy a pipeline in browser and database
    respond_with Status.destroy(params['id']).to_json
  end

  private

  def stage_params
    params.permit(:id, :name, :description, :pipeline_id)
  end
end
