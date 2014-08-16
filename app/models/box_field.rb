class BoxField < ActiveRecord::Base
  belongs_to :box
  belongs_to :field

  fuzzily_searchable :value
end
