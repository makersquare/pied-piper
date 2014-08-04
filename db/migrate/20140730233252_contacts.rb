class Contacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
        t.string :name
        t.string :email
        t.string :phoneNum
        t.string :city
    end
  end
end
