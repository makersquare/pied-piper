class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :event, polymorphic: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
