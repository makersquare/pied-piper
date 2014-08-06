class RetrievePipeline < TransactionScript
  def run(pipeline_id)
    pipeline_entity = Pipeline.find(pipeline_id)
    pipeline_stages = pipeline_entity.stages
    stage_boxes = {}
    pipeline_stages.each { |stage|
      stage_boxes[stage] = stage.boxes
    }
    return success(:data => {pipeline: pipeline_entity.to_json, pipeline_stages: pipeline_stages.to_json, stage_boxes: stage_boxes.to_json})
  end
end