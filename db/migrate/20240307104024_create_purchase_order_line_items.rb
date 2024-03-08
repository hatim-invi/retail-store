class CreatePurchaseOrderLineItems < ActiveRecord::Migration[7.1]
  def change
    create_table :purchase_order_line_items do |t|
      t.integer :quantity
      t.integer :rate
      t.references :product, null: false, foreign_key: true
      t.references :purchase_order, null: false, foreign_key: true
      t.timestamps
    end
  end
end
