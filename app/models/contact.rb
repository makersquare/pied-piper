class Contact < ActiveRecord::Base
  has_many :boxes, dependent: :destroy
  has_many :stages, through: :boxes
  has_many :notes, through: :boxes
end
