class Notes < ActiveRecord::Base
  belongs_to :contacts
  belongs_to :boxes
end
