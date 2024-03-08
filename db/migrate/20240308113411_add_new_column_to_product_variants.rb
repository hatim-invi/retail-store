class AddNewColumnToProductVariants < ActiveRecord::Migration[7.1]
  def change
    change_column :product_variants, :description, :text
    add_column :product_variants, :name, :string
  end
end
