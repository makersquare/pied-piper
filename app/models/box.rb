class Box < ActiveRecord::Base
  belongs_to :pipeline
  belongs_to :contact
  has_many :box_fields
  has_many :fields, through: :box_fields
  has_many :box_histories
  has_many :notes
end
