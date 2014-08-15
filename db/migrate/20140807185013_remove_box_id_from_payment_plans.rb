class RemoveBoxIdFromPaymentPlans < ActiveRecord::Migration
  def change
    remove_column :payment_plans, :box_id, :integer
  end
end
