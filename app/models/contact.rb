class Contact < ActiveRecord::Base
  has_many :boxes
  has_many :stages, through: :boxes
  has_many :notes, through: :boxes
  has_many :box_fields
  has_many :fields, through: :boxes
  has_many :box_fields, through: :boxes
end
