class Box < ActiveRecord::Base
  belongs_to :stage
  belongs_to :contact
  belongs_to :pipeline
  has_many :box_fields, dependent: :destroy
  has_many :fields, through: :box_fields
  has_many :box_histories, dependent: :destroy
  has_many :notes, dependent: :destroy
end
