class AddStageIDtoBoxes < ActiveRecord::Migration
  def change
    change_table :boxes do |t|
      t.references :stage
      t.references :pipeline
      t.integer :pipeline_location
    end
  end
end
