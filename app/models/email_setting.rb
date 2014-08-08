class EmailSetting < ActiveRecord::Base
  belongs_to :pipeline_user
end
