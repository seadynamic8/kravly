ActiveAdmin.register Board do

  menu priority: 3

  scope :newly_created
  scope :recent

  index do
    selectable_column
    column :id, sortable: :id do |board|
      link_to board.id, admin_board_path(board)
    end
    column :name
    column :user, sortable: :user_id
    column :slug
    column :created_at
    column :updated_at
    default_actions
  end
  
end
