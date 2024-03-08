class CreatePurchaseOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :purchase_orders do |t|
      t.date :date
      t.references :seller, null: false, foreign_key: true
      t.timestamps
    end
  end
end
