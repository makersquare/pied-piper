class DropTrigramsTable < ActiveRecord::Migration
  def change
    drop_table :trigrams
  end
end
