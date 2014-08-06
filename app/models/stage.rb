class Stage < ActiveRecord::Base
  belongs_to :pipeline
  has_many :boxes, dependent: :destroy
end