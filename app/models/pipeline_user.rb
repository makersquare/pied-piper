class PipelineUser < ActiveRecord::Base
  belongs_to :pipeline
  belongs_to :user
  has_one :email_setting, dependent: :destroy
end
