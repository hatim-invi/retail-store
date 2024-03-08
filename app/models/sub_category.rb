class SubCategory < ApplicationRecord
  belongs_to :category
  has_many :products

  # for active admin

  def self.ransackable_associations(auth_object = nil)
    ["category", "products"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at","category_id", "id", "id_value", "name", "updated_at"]
  end

   #validations
   validates :name, presence: true

   def products_count
    products.count
   end
end
