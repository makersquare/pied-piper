class PipelineField < ActiveRecord::Base
  belongs_to :pipeline
  belongs_to :field
end
