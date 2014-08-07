class PaymentPlan < ActiveRecord::Base
  has_many :boxes
  belongs_to :stage
end
