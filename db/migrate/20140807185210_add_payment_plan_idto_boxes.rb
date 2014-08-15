class AddPaymentPlanIdtoBoxes < ActiveRecord::Migration
  def change
    change_table :boxes do |t|
      t.references :payment_plan
    end
  end
end
