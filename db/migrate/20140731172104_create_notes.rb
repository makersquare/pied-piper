class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
        t.references :user
        t.references :box
        t.text :notes
        t.timestamp
    end
  end
end
