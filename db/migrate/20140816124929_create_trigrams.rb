class CreateTrigrams < ActiveRecord::Migration
  # extend Fuzzily::Migration
  def up
    create_table :trigrams
  end
end
