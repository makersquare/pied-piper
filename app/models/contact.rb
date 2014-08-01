class Contact < ActiveRecord::Base
  has_many :contact_pipelines
  has_many :pipelines, through: :contact_pipelines
  has_many :boxes
  has_many :notes, through: :boxes
end
