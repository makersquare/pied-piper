class AddOauthToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove :admin
      t.string :provider
      t.string :uid
      t.string :oauth_token
      t.datetime :oauth_expires_at
    end
  end
end
