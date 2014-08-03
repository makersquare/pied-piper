class BoxHistory < ActiveRecord::Base
  belongs_to :box
  belongs_to :pipelines
  has_many :stages
end
