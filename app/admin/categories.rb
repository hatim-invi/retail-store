ActiveAdmin.register Category do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name
  #
  # or
  #
  # permit_params do
  #   permitted = [:name]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  permit_params :name


  index do
    sr = 0
    selectable_column
    column "Sr.No." do |category|
      sr+=1
    end
    column "Category Name", :name, sortable: false
    actions
  end

  filter :name, label: "Category name"

  show do
    panel "Sub-Categories of #{category.name}", style: "width: 80%" do
    sr=0
      table_for category.sub_categories do
        column "Sr.No." do |s|
          sr+=1
        end
        column "Sub-Category Name" do |sub_category|
          link_to sub_category.name, admin_sub_category_path(sub_category)
        end
      end
    end
  end

  sidebar "Category Details", only: :show do
    attributes_table_for category do
      row :id
      row :name
      row :subcategories_count
      row :products_count
      row :created_at
      row :updated_at
    end
  end




end
