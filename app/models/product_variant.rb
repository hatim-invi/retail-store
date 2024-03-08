class ProductVariant < ApplicationRecord
  belongs_to :product

  # for active admin
  def self.ransackable_associations(auth_object = nil)
    ["product"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "id_value", "product_id", "quantity", "updated_at","name"]
  end
end
