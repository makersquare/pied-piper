class PipelinesController < ApplicationController
  respond_to :json
  # before_filter :logged_in?
  # before_filter :is_pipeline_admin?, :only => [:destroy, :trash, :update, :add_to_pipeline, :remove_from_pipeline, :update_access_to_pipeline]
  # We need to check and make sure the request is coming from
  # an admin of the pipeline

  def index
    #This is the right code to respond with the correct pipelines on the sidebar but
    #it is inconvenient for dev purposes to have people sign in so I will leave it commented out

    # result = RetrieveUserPipelines.run(current_user.id)
    # if result.success?
    #   respond_with result.data
    # else
    #   respond_with result.error
    # end
    # FIXME
    result = RetrieveAllPipelineInfo.run(params)
    if result.success?
      respond_with result.pipelines.map(&:to_h)
    else
      respond_with(result.error, status: :unprocessable_entity)
    end
  end

  def queue_pipeline
    Resque.enqueue(CreatePipeline, "test #{rand(100)}")
    respond_with true, location: '/pipelines'
  end

  # TSX to check and make sure valid. Backend check for if
  # people concurrently add pipelines. This needs to check
  # if the request is coming for an admin of the entire app or
  # allow any user to create pipelines
  def create
    respond_with CreatePipelineScript.run(name: params[:name], user_id: current_user.id).data
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


  #Method takes a pipeline id and a user id and adds the user to the pipeline
  # This is a mass assignment so I think I have to permit the user_id.
  # Need to first check and see if target user is not already part of pipeline
  def retrieve_collaborators
    result = RetrieveCollaborators.run(params[:pipeline_id])
    if result.success?
      respond_with result.data.to_json
    else
      respond_with result.error.to_json
    end
  end

  #should probably correct to use strong params here
  def add_to_pipeline
    result = AddUserPipeline.run({id: params["id"], user_id: params["newUser"]["user"]["id"], pipeline_admin: params["newUser"]["admin"]})
    if result.success?
      render json: result.data
    else
      respond_with result.error
    end
  end

  def remove_from_pipeline
    result = RemoveUserPipeline.run(pipeline_params)
    if result.success?
      respond_with true
    else
      respond_with result.error
    end
  end
  #Using render json: because I got some weird error with respond_with
  def update_access_to_pipeline
    result = UpdateUserPipeline.run(pipeline_params)
    if result.success?
      render json: result.data
    else
      respond_with result.error
    end
  end


  private

  #Takes the user_id from the session of the person making request
  # Also need the pipeline ID, return true if user is the admin
  #This blocks access to admin only pipeline methods in the CTRL
  def is_pipeline_admin?
    pipeline_user = PipelineUser.find_by(user_id: current_user.id, pipeline_id: params[:id])
    return pipeline_user.admin || false
  end

  def pipeline_params
    params.permit(:id, :pipeline_id, :name, :trashed, :user_id, :pipeline_admin, :newUser)
  end
end
