class BoxHistory < ActiveRecord::Migration
  def change
    create_table :box_history do |t|
      t.references :box
      t.references :stage
      t.timestamps
    end
  end
end
