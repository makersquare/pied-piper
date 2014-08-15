class StageFields < ActiveRecord::Base
  belongs_to :stage
  belongs_to :field
end
