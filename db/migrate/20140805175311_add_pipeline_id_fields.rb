class AddPipelineIdFields < ActiveRecord::Migration
  def change
    change_table :fields do |t|
      t.references :pipeline
    end
  end
end
