class CreatePipelineUsers < ActiveRecord::Migration
  def change
    create_table :pipeline_users do |t|
      t.references :user
      t.references :pipeline
      t.boolean :admin 
      t.timestamps
    end
  end
end
