class FixPhoneNumCol < ActiveRecord::Migration
  def change
    remove_column :contacts, :phoneNum
    add_column :contacts, :phonenumber, :string
  end
end
