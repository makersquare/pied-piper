class ContactPipeline < ActiveRecord::Base
  belongs_to :contact
  belongs_to :pipeline
end
