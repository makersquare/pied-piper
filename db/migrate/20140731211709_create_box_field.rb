class CreateBoxField < ActiveRecord::Migration
  def change
    create_table :box_fields do |t|
      t.references :field
      t.references :box
      t.string :value
    end
  end
end
