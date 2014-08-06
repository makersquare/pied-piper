class AddWebHookIdtoUser < ActiveRecord::Migration
  def change
    add_column :users, :webhook_id, :string
  end
end
