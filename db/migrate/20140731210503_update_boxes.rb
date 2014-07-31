class UpdateBoxes < ActiveRecord::Migration
  def change
    add_column :boxes, :pipeline_location, :integer
  end
end
