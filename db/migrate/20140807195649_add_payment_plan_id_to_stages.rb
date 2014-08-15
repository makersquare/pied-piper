class AddPaymentPlanIdToStages < ActiveRecord::Migration
  def change
    add_column :stages, :standard_payment_plan_id, :integer
    add_column :stages, :payment, :boolean
  end
end
