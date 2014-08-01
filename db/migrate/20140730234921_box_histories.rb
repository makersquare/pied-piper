class BoxHistories < ActiveRecord::Migration
  def change
    create_table :box_histories do |t|
      t.references :box
      t.references :stage
      t.integer :stage_from
      t.timestamps
    end
  end
end
