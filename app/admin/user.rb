ActiveAdmin.register User do

  menu priority: 2

  index do
    selectable_column
    column :id, sortable: :id do |user|
      link_to user.id, admin_user_path(user)
    end
    column :username
    column :email
    column :admin
    column :display
    column :slug
    column :created_at
    column :updated_at
    default_actions
  end
  
end
