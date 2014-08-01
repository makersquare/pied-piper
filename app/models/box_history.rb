class BoxHistory < ActiveRecord::Base
  belongs_to :boxes
  belongs_to :pipelines
end
