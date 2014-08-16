class Trigram < ActiveRecord::Base
  include Fuzzily::Model
  trigrams_owner_id_column_type = :uuid
end
