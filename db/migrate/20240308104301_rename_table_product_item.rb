class RenameTableProductItem < ActiveRecord::Migration[7.1]
  def change
    rename_table :product_items, :product_variants
  end
end
