class UpdateBoxHistory < ActiveRecord::Migration
  def change
    change_table :box_history do |t|
      add_column :stage_from
    end
  end
end
