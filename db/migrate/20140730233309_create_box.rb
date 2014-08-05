class CreateBox < ActiveRecord::Migration
  def change
    create_table :boxes do |t|
      t.references :contact
    end
  end
end
