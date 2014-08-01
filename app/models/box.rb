class Box < ActiveRecord::Base
  belongs_to :pipelines
  belongs_to :contacts
  has_many :fields, through: :box_fields
  has_many :box_histories
  has_many :notes
end
