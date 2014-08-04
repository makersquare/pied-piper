class Field < ActiveRecord::Base
  has_many :box_fields
  has_many :boxes, through: :box_fields
  has_many :pipeline_fields
  has_many :pipelines, :through => :pipeline_fields
end
