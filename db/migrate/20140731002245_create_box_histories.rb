class CreateBoxHistories < ActiveRecord::Migration
  def change
    create_table :box_histories do |t|

      t.timestamps
    end
  end
end
