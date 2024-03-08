ActiveAdmin.register Seller do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :phone_number
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :phone_number]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

 permit_params :name, :phone_number

  index do
    sr = 0
    selectable_column
    column "Sr.No." do |seller|
      sr+=1
    end
    column "Name", :name
    column "Phone Number", :phone_number
    actions
  end

  filter :purchase_orders
  filter :name
  filter :phone_number


    show do
      panel "Table of Contents" do
        sr=0
        table_for seller.purchase_orders do
          column "Sr.No." do |s|
            sr+=1
          end
          column "Name" do |purchase_order|
            link_to purchase_order.name, admin_purchase_order_path(purchase_order)
          end
        end
      end
    end

    sidebar "Seller Details", only: :show do
      attributes_table_for seller do
        row :id
        row :name
        row :phone_number
        row :purchase_orders_count
      end
    end

end
