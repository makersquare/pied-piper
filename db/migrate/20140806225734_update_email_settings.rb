class UpdateEmailSettings < ActiveRecord::Migration
  def change
    change_column :email_settings, :setting, :string, :default => "Realtime"
  end
end
