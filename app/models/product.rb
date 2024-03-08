class Product < ApplicationRecord
  belongs_to :sub_category
  has_one :category, through: :sub_category
  has_many :purchase_order_line_items
  has_many :purchase_orders, through: :purchase_order_line_items
  has_many :product_variants

  enum measured_in: ['Kilogram', 'Meter', 'Pound', 'Feet', 'Liter', 'MiliLiter', 'Piece']

  # for active admin
  def self.ransackable_associations(auth_object = nil)
    ["category", "sub_category","purchase_order_line_items","purchase_orders","product_variants"]
  end

  def self.ransackable_attributes(auth_object = nil)
  ["created_at", "description", "id", "id_value", "measured_in", "min_profit_margin", "name", "profit_margin", "sub_category_id", "updated_at"]
  end

   #validations

   validates :name, presence: true
   validates :profit_margin, presence: true, numericality: { only_integer: true }
   validates :min_profit_margin, presence: true, numericality: { only_integer: true }
   validates :measured_in, presence: true
   validates :description, presence: true
   validates :sub_category_id, presence: true

    def category_id
    end

    def category
      product = Product.joins(sub_category: :category).find_by(sub_categories: {id: self.sub_category_id})
      return product.sub_category.category
    end

end
