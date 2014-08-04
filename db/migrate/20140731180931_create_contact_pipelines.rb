class CreateContactPipelines < ActiveRecord::Migration
  def change
    create_table :contact_pipelines do |t|
      t.references :contact
      t.references :pipeline
    end
  end
end
