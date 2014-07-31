class UpdateNotes < ActiveRecord::Migration
  def change
    remove_column :boxes, :notes, :text
  end
end
