class PurchaseOrder < ApplicationRecord
  belongs_to :seller
  has_many :purchase_order_line_items
  has_many :products, through: :purchase_order_line_items
  accepts_nested_attributes_for :purchase_order_line_items, allow_destroy: true

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "date", "id", "id_value", "seller_id", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["purchase_order_line_items", "seller", "products"]
  end

  #validations

  validates :seller, presence:true
  validates :date, presence:true, format: { with: /\A\d{4}-\d{2}-\d{2}\z/, message: "should be in the format YYYY-MM-DD" }


  def name
   "PO-#{id}"
  end

end
