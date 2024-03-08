ActiveAdmin.register Product do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :price
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :price]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  permit_params :name, :measured_in, :profit_margin, :min_profit_margin, :sub_category_id, :description


  index do
    sr = 0
    selectable_column
    column "Sr.No." do |product|
      sr+=1
    end
    column "Product Name", :name, sortable: false
    column "Profit Margin", :profit_margin, sortable: false
    column "Category" do |product|
      link_to product.sub_category.category.name, admin_category_path(product.sub_category.category)
    end
    column "Sub-Category" do |product|
      link_to product.sub_category.name, admin_sub_category_path(product.sub_category)

    end
    actions
  end

  filter :name
  filter :profit_margin
  filter :category
  filter :sub_category



  form do |f|
    inputs 'Product details' do
      input :name, label: "Product name"
      input :measured_in
      input :description, label: "Product description", input_html: { rows: 6, cols: 40 }
      input :profit_margin
      input :min_profit_margin, label: "Minimum profit margin"
    end

    inputs 'Select category and sub-category' do
      input :category_id, label: "Category", as: :select, collection: Category.all.map {|c| [c.name,c.id]}
      input :sub_category_id, label: "Sub-category", as: :select, collection: ['Please select a category first'], input_html: { disabled: true }, include_blank: false
    end
    actions
  end

  show do
      attributes_table do
        row :name
        row :measured_in
        row :min_profit_margin
        row :profit_margin
        row :category
        row :sub_category
        row :created_at
        row :updated_at
        row :description
      end
  end
end
