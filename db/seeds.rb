require 'faker'

PurchaseOrderLineItem.delete_all
PurchaseOrder.delete_all
Seller.delete_all
Product.delete_all
SubCategory.delete_all
Category.delete_all
AdminUser.delete_all


categories = [
  "Electronics",
  "Clothing",
  "Home & Kitchen",
  "Sports & Outdoors",
  "Books",
  "Beauty & Personal Care",
  "Toys & Games",
  "Health & Wellness"
]

subcategories = {
  "Electronics" => [
    "Smartphones",
    "Laptops",
    "Tablets",
    "Cameras",
    "Televisions",
    "Headphones",
    "Speakers",
    "Accessories"
  ],
  "Clothing" => [
    "Men's Clothing",
    "Women's Clothing",
    "Kids' Clothing",
    "Shoes",
    "Accessories"
  ],
  "Home & Kitchen" => [
    "Furniture",
    "Cookware",
    "Appliances",
    "Home Decor",
    "Bedding",
    "Storage & Organization"
  ],
  "Sports & Outdoors" => [
    "Fitness Equipment",
    "Outdoor Recreation",
    "Athletic Clothing",
    "Footwear",
    "Accessories"
  ],
  "Books" => [
    "Fiction",
    "Non-fiction",
    "Children's Books",
    "Textbooks",
    "Magazines"
  ],
  "Beauty & Personal Care" => [
    "Skincare",
    "Haircare",
    "Makeup",
    "Fragrances",
    "Personal Care Appliances"
  ],
  "Toys & Games" => [
    "Action Figures",
    "Board Games",
    "Puzzles",
    "Dolls & Accessories",
    "Educational Toys"
  ],
  "Health & Wellness" => [
    "Vitamins & Supplements",
    "Personal Care",
    "Fitness Accessories",
    "Health Monitors"
  ]
}

categories.each do |category_name|
  category = Category.create(name: category_name)
  subcategories[category_name].each do |subcategory_name|
    SubCategory.create(name: subcategory_name, category_id: category.id)
  end
end

puts "Categories and sub-categories generated"


measured_in_options = ['Kilogram', 'Meter', 'Pound', 'Feet', 'Liter', 'MiliLiter', 'Piece']

SubCategory.all.each do |subcategory|
  rand(7..12).times do
    Product.create(
      sub_category_id: subcategory.id,
      name: Faker::Commerce.product_name,
      measured_in: measured_in_options.sample,
      min_profit_margin: rand(5..10),
      profit_margin: rand(15..30),
      description: Faker::Lorem.paragraph(sentence_count: 3))
  end
end

puts "Products generated"


25.times do
  Seller.create(
    name: Faker::Name.name,
    phone_number: Faker::PhoneNumber.phone_number
  )
end

puts "Sellers generated"

seller_ids = Seller.pluck(:id)

50.times do
  PurchaseOrder.create(
    date: Faker::Date.between(from: 1.year.ago, to: Date.today),
    seller_id: seller_ids.sample
  )
end

puts "purchase orders generated"

purchase_order_ids = PurchaseOrder.pluck(:id)
product_ids = Product.pluck(:id)

600.times do
  PurchaseOrderLineItem.create(
    quantity: Faker::Number.between(from: 1, to: 100),
    rate: Faker::Number.between(from: 1000, to: 10000),
    product_id: product_ids.sample,
    purchase_order_id: purchase_order_ids.sample
  )
end

puts "purchase order line items generated"

product_variants = PurchaseOrderLineItem.joins(purchase_order: :seller)
                                         .group('sellers.name', 'purchase_order_line_items.product_id')
                                         .select('purchase_order_line_items.product_id AS product_id', 'sellers.name AS seller_name', 'SUM(purchase_order_line_items.quantity) AS total_quantity')

product_variants.each do |product_variant|
  product = Product.find(product_variant.product_id)
  seller_name = product_variant.seller_name
  total_quantity = product_variant.total_quantity

  # Find existing variants count for the product
  existing_variants_count = ProductVariant.where(product_id: product.id).count

  # Create new product variant
  ProductVariant.create(product_id: product.id,
                        quantity: total_quantity,
                        description: Faker::Lorem.paragraph(sentence_count: 8),
                        name: "#{product.name} - variant - #{existing_variants_count + 1}",
                        seller_name: seller_name)
end


puts "product items generated"


AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
