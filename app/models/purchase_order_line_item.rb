class PurchaseOrderLineItem < ApplicationRecord
  belongs_to :product
  belongs_to :purchase_order

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "product_id", "purchase_order_id", "quantity", "rate", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["product", "purchase_order"]
  end

  # validations
  validates :rate, presence: true, numericality: { only_integer: true }
  validates :quantity, presence: true, numericality: {only_integer: true}

  def name
    "#{purchase_order.name}-LT-#{self.id}"
  end

  def measured_in
  end
end
