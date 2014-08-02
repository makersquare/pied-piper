class Notes < ActiveRecord::Base
  belongs_to :contact
  belongs_to :box
end
