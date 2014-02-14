ActiveAdmin.register UserVote do

  menu priority: 9

  index do
    selectable_column
    column :id, sortable: :id do |user_vote|
      link_to user_vote.id, admin_user_vote_path(user_vote)
    end
    column :user, sortable: :user_id
    column :idea, sortable: :idea_id
    column :created_at
    column :updated_at
    default_actions
  end
  
end
