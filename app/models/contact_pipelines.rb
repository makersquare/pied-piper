class ContactPipelines < ActiveRecord::Base
  belongs_to :contacts
  belongs_to :pipelines
end
