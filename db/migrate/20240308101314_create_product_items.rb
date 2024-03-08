class CreateProductItems < ActiveRecord::Migration[7.1]
  def change
    create_table :product_items do |t|
      t.references :product , null: false, foreign_key: true
      t.integer :quantity
      t.string :description
      t.timestamps
    end
  end
end
