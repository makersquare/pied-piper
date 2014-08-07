class RetrievePipeline < TransactionScript
  def run(pipeline_id)
    #Need to also return fields associated pipeline
    #contacts associated with Boxes
    # need box_fields
    pipeline_entity = Pipeline.find(pipeline_id)
    pipeline_stages = pipeline_entity.stages
    stage_boxes = {}
    pipeline_stages.each { |stage|
      stage_boxes[stage.id] = stage.boxes
    }

    return success(:data => {pipeline: pipeline_entity, pipeline_stages: pipeline_stages, stage_boxes: stage_boxes})
  end
end


# {
#   pipeline: {
#     entity: ___,
#     fields: ["attribute1", "attribute2"],
#     stages: [
#       {
#         entity: ___,
#         boxes: [
#           {
#             contact_entity: ___,
#             fields: [{attribute1: "value1", attribute2: "value2"}]
#           }
#         ]
#       }
#     ]
#   }
# }