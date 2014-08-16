class Pipeline < ActiveRecord::Base
  has_many :stages, dependent: :destroy
  has_many :pipeline_users
  has_many :users, :through => :pipeline_users
  validates :name, uniqueness: true
  has_many :fields, dependent: :destroy
  has_many :boxes
  has_many :contacts, through: :boxes

  fuzzily_searchable :name
end
