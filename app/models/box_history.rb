class BoxHistory < ActiveRecord::Base
  belongs_to :box
  belongs_to :pipeline
  has_many :stages
end
