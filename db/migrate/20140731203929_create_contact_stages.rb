class CreateContactStages < ActiveRecord::Migration
  def change
    create_table :contact_stages do |t|

      t.timestamps
    end
  end
end
