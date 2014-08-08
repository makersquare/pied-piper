class CreatePaymentPlans < ActiveRecord::Migration
  def change
    create_table :payment_plans do |t|
      t.integer :total_due
      t.integer :num_payments
      t.datetime :due_date
      t.references :box

      t.timestamps
    end
  end
end
