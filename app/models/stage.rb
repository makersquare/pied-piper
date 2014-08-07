class Stage < ActiveRecord::Base
  belongs_to :pipeline
  has_many :boxes, dependent: :destroy
  has_many :user_stages
  has_many :stages, through: :user_stages
end