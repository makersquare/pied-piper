class DeleteUidUsers < ActiveRecord::Migration
  def change
    remove_column :users, :uid
  end
end
