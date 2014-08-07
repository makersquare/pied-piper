class Box < ActiveRecord::Migration
  def change
    create_table :boxes do |t|
      t.references :contact
      t.references :pipeline
      t.references :stage
      t.text :notes
    end
  end
end
