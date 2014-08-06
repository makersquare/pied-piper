class RetrievePipeline < TransactionScript
  def run(pipeline_id)
    pipeline_entity = Pipeline.find(pipeline_id)
    pipeline_stages = pipeline_entity.stages
    stage_boxes = {}
    pipeline_stages.each { |stage|
      stage_boxes[stage.id] = stage.boxes
    }
    return success(:data => {pipeline: pipeline_entity, pipeline_stages: pipeline_stages, stage_boxes: stage_boxes})
  end
end
