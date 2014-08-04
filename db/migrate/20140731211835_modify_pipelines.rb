class ModifyPipelines < ActiveRecord::Migration
  def change
    change_table :pipelines do |t|
      t.column :trashed, :boolean
    end
  end
end
