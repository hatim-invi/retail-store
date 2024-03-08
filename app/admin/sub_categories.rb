ActiveAdmin.register SubCategory do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :category_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :category_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  permit_params :category_id, :name


  index do
    sr = 0
    selectable_column
    column "Sr.No." do |sub_category|
      sr+=1
    end
    column "Sub-Category Name", :name, sortable: false
    column "Category Name" do |sub_category|
      link_to sub_category.category.name, admin_category_path(sub_category.category)
    end
    actions
  end

  filter :name, label: "Sub-category name"
  filter :category, label: "Category name"

  show do
    panel "Products of #{sub_category.name}", style: "width: 80%" do
    sr=0
      table_for sub_category.products do
        column "Sr.No." do |s|
          sr+=1
        end
        column "Product Name" do |product|
          link_to product.name, admin_product_path(product)
        end
      end
    end
  end

  sidebar "Category Details", only: :show do
    attributes_table_for sub_category do
      row :id
      row :name
      row :products_count
      row :created_at
      row :updated_at
    end
  end


  collection_action :get_categories, method: :get do
    id = params[:id]
    sub_categories = SubCategory.where(category_id: id)
    render json: sub_categories
  end
end
