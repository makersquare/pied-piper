class ChangeEmailSettings < ActiveRecord::Migration
  def change
    change_table :email_settings do |t|
      t.references :pipeline_user
      t.remove :user_id
      t.remove :pipeline_id
    end
  end
end
