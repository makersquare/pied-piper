class CreatePipelineFields < ActiveRecord::Migration
  def change
    create_table :pipeline_fields do |t|
      t.references :pipeline
      t.references :field
    end
  end
end