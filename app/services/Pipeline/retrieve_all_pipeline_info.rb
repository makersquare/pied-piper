# Retrieves all pipelines from databases, but also
# injects data about which stages are in the pipeline.

class RetrieveAllPipelineInfo < TransactionScript
  def run(params)
    # Gather all contact information, but also send data about the pipelines
    pipelines = Pipeline.all.map do |pipeline|
      # Convert to OpenStruct for ease of use
      pipeline_struct = OpenStruct.new(pipeline.serializable_hash)
      add_stage_info_to_pipeline(pipeline, pipeline_struct)
      pipeline_struct
    end

    return success(pipelines: pipelines)
  end

  # Retrieves information about which stages belong to a pipeline.
  def add_stage_info_to_pipeline(pipeline, pipeline_struct)
    stages = pipeline.stages
    stage_contact_count_arr = stages.map do |stage|
      stage.contacts.count
    end
    # Adds contact count to pipeline
    pipeline_struct["contact_count"] = stage_contact_count_arr.reduce(:+)
    # Converts OpenStruct to hash
    pipeline_struct.stages = stages.to_a.map(&:serializable_hash)
    # Adds contact count to each stage
    pipeline_struct.stages.each_with_index do |stage, i|
      stage["contact_count"] = stage_contact_count_arr[i]
    end
  end
end
