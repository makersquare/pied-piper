class FixphonenumberCol < ActiveRecord::Migration
  def change
    remove_column :contacts, :phonenumber
    add_column :contacts, :phonenumber, :string
  end
end
