class Field < ActiveRecord::Base
  has_many :box_fields
  has_many :boxes, through: :box_fields
  belongs_to :pipeline
end
