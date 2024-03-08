class CreateTableForCategoriesSubCategoriesProduct < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.timestamps
    end

    create_table :sub_categories do |t|
      t.string :name
      t.references :category, null: false, foreign_key: true
    end

    remove_column :products, :price
    add_column :products, :measured_in, :integer
    add_column :products, :min_profit_margin, :integer
    add_column :products, :profit_margin, :integer
    add_column :products, :sub_category_id, :bigint
    add_foreign_key :products, :sub_categories
    add_column :products, :description, :text

  end
end
