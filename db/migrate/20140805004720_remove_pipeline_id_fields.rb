class RemovePipelineIdFields < ActiveRecord::Migration
  def change
    remove_column :fields, :pipeline_id
  end
end
