class CreateStages < ActiveRecord::Migration
  def change
    create_table :stages do |t|
      t.string :name
      t.text :description
      t.references :pipeline
      t.integer :pipeline_location
      t.timestamps
    end
  end
end
