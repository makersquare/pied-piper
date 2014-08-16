class Field < ActiveRecord::Base
  has_many :box_fields
  has_many :boxes, through: :box_fields
  belongs_to :pipeline
  has_many :stage_fields
  has_many :stages, through: :stage_fields

  fuzzily_searchable :field_name
end
