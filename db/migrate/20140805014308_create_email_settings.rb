class CreateEmailSettings < ActiveRecord::Migration
  def change
    create_table :email_settings do |t|
      t.integer :user_id
      t.string :setting
      t.integer :pipeline_id

      t.timestamps
    end
  end
end
