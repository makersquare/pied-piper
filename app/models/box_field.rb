class BoxField < ActiveRecord::Base
  belongs_to :boxes
  belongs_to :fields
end
