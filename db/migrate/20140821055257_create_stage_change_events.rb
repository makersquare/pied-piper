class CreateStageChangeEvents < ActiveRecord::Migration
  def change
    create_table :stage_change_events do |t|
      t.references :box_history

      t.timestamps
    end
  end
end
