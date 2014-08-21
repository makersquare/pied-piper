class PipelineUser < ActiveRecord::Base
  belongs_to :pipeline
  belongs_to :user
end
