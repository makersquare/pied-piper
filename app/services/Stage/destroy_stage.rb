# Given the id of the destroyed stage, finds contacts associated
# with that stage and moves them to the default stage for that pipeline
class DestroyStage < TransactionScript
  def run(params)

    if params[:stage_id].nil?
      return failure(:no_stage_id_passed)
    end

    stage = Stage.where(id: params[:stage_id]).first

    if stage.nil?
      return failure(:invalid_stage_id)
    end

    if stage.pipeline_location == 0
      return failure(:cannot_destroy_default_stage)
    end

    stage_pipeline = Stage.where(id: params[:stage_id]).first.pipeline_id
    default = Stage.where(pipeline_id: stage_pipeline, pipeline_location: 0).first

    if default.nil?
      return failure(:no_default_stage_defined)
    end

    contact_boxes = Box.where(stage_id: params[:stage_id])
    contact_boxes.update_all(stage_id: default.id, pipeline_location: 0)
    updated = Box.where(stage_id: default.id)

    Stage.find(params[:stage_id]).destroy

    return success(contact_boxes: updated)
  end
end
