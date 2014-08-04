class BoxHistory < ActiveRecord::Base
  belongs_to :box
  has_many :stages
end
