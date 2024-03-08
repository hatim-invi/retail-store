ActiveAdmin.register PurchaseOrder do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :date, :seller_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:date, :seller_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

permit_params :seller_id, :date, purchase_order_line_items_attributes: [:product_id, :id, :rate, :quantity, :_destroy]

  index do
    sr = 0
    selectable_column
    column "Sr.No." do |purchase_order|
      sr += 1
    end
    column "Name", :name
    column "Seller Name", sortable: true do |purchase_order|
      link_to purchase_order.seller.name, admin_seller_path(purchase_order.seller)
    end
    column "Date", :date

    actions
  end

  filter :seller
  filter :date

    show do
      panel "Purchase Order Items" do
        sr = 0
        table_for purchase_order.purchase_order_line_items do
          column "Sr.No." do |purchase_order_line_item|
            sr+=1
          end
          column "Product Name" do |purchase_order_line_item|
            link_to purchase_order_line_item.product.name, admin_product_path(purchase_order_line_item.product)
          end
          column "Quantity" do |purchase_order_line_item|
            quantity = purchase_order_line_item.quantity
            "#{quantity} #{purchase_order_line_item.product.measured_in}"
          end
          column "Rate (Rupees)",:rate
        end
      end
    end

    sidebar "Purchase Order Details", only: :show do
      attributes_table_for purchase_order do
        row :name
        row :seller
        row :date
        row :date
        row :created_at
        row :updated_at
      end
    end




  form do |f|
    inputs 'Purchase Details' do
      input :seller, label: "Seller name"
      input :date, label: "Purchase Date"
      has_many :purchase_order_line_items, heading: false, new_record: 'Add product', remove_record: 'Remove product', allow_destroy: true do |a|
        a.input :product
        a.input :quantity, label: 'Quantity'
        a.input :measured_in, label: 'Measured In', input_html: { readonly: true}
        a.input :rate
      end
    end
    actions
  end

  collection_action :measured_in, method: :get do
    id = params[:product_id]
    product = Product.find(id)
    render json: product
  end



end
