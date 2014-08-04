class Contact < ActiveRecord::Base
  has_many :boxes
  has_many :pipelines, through: :boxes
  has_many :notes, through: :boxes
end
