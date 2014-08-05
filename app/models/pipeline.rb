class Pipeline < ActiveRecord::Base
  has_many :stages
  has_many :pipeline_users
  has_many :users, :through => :pipeline_users
  validates :name, uniqueness: true
  has_many :fields
end
