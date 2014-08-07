class CreateStageFields < ActiveRecord::Migration
  def change
    create_table :stage_fields do |t|
      t.references :stage
      t.references :field
      t.boolean :visible
    end
  end
end
