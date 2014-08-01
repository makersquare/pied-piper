class Pipeline < ActiveRecord::Base
  has_many :stages
  has_many :pipeline_users
  has_many :users, :through => :pipeline_users
  has_many :contact_pipelines
  has_many :contacts, :through => :contact_pipelines
  validates :name, uniqueness: true
end
