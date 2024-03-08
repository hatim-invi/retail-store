class Seller < ApplicationRecord
  has_many :purchase_orders

  def self.ransackable_associations(auth_object = nil)
    ["purchase_orders"]
  end
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "name", "phone_number", "updated_at"]
  end


  #validations

  validates :name, presence: true
  validates :phone_number, presence: true, format: { with: /\A\d{10}\z/, message: "should be 10 digits" }


  def purchase_orders_count
    purchase_orders.count
  end
end
