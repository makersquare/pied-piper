class Field < ActiveRecord::Base
  belongs_to :pipeline
  has_many :box_fields
end
