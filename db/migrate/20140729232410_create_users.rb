class CreateUsers < ActiveRecord::Migration
  # This is made for the purpose of stubbing users
  # We'll build a real auth system later
  def change
    create_table :users do |t|
      t.string :name
      # t.string :email
      t.boolean :admin

      t.timestamps
    end
  end
end
