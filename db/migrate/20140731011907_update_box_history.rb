class UpdateBoxHistory < ActiveRecord::Migration
  def change
    add_column :box_history, :stage_from, :integer
  end
end
