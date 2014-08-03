class DropBoxHistory < ActiveRecord::Migration
  def change
    # drop_table :box_history
    drop_table :box_histories
  end
end
