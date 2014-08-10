class CreateUserStages < ActiveRecord::Migration
  def change
    create_table :user_stages do |t|
      t.references :user
      t.references :stage
      t.boolean :hidden
    end
  end
end