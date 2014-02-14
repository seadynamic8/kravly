ActiveAdmin.register Comment do

  menu priority: 7

  scope :recent

  index do
    selectable_column
    column :id, sortable: :id do |comment|
      link_to comment.id, admin_comment_path(comment)
    end
    column :body do |comment|
      truncate comment.body, length: 50
    end
    column "Idea", :commentable, sortable: :commentable_id
    column :user, sortable: :user_id
    column :created_at
    column :updated_at
    default_actions
  end

  show do |comment|
    attributes_table do
      row :id
      row :body
      row :commentable
      row :commentable_type
      row :user
      row :lft
      row :rgt
      row :created_at
      row :updated_at
    end
  end
  
end
