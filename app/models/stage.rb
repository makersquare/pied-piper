class Stage < ActiveRecord::Base
  belongs_to :pipeline
  has_many :stage_boxes
  has_many :boxes, through: :stage_boxes
end
