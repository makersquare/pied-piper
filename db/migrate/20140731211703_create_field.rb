class CreateField < ActiveRecord::Migration
  def change
    create_table :fields do |t|
      t.references :pipeline
      t.string :type
      t.string :field_name
    end
  end
end
