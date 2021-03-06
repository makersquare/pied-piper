class Stage < ActiveRecord::Base
  belongs_to :pipeline
  belongs_to :payment_plan
  has_many :boxes
  has_many :contacts, through: :boxes
  has_many :user_stages
  has_many :stages, through: :user_stages
  has_many :stage_fields
  has_many :fields, through: :stage_fields
end

