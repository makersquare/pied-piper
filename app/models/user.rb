class User < ActiveRecord::Base
  has_many :pipeline_users
  has_many :pipelines, :through => :pipeline_users
end