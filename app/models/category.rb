class Category < ApplicationRecord
  has_many :sub_categories
  has_many :products, through: :sub_categories

  # for active admin
  def self.ransackable_associations(auth_object = nil)
    ["sub_categories", "products"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "name", "updated_at"]
  end
   #validations
   validates :name, presence: true



  def subcategories_count
    sub_categories.count
  end

  def products_count
    products.count
  end
end
