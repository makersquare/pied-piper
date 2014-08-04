class UpdateFieldsTable < ActiveRecord::Migration
  def change
    add_column :fields, :field_type, :string
    remove_column :fields, :type, :string
  end
end
