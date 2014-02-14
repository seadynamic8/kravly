ActiveAdmin.register Idea do

  menu priority: 4

  scope :popular
  scope :recent

  index do
    selectable_column
    column :id, sortable: :id do |idea|
      link_to idea.id, admin_idea_path(idea)
    end
    column :title
    column :content do |idea|
      truncate( simple_format(idea.content), length: 50)
    end
    column :votes, sortable: :votes do |idea|
      div class: "idea-votes" do
        idea.votes
      end
    end
    column :board, sortable: :board_id
    column :slug
    # column :commitment
    # column :looking_for
    # column :market
    column :created_at
    column :updated_at
    default_actions
  end

  show do |idea|
    attributes_table do
      row :title
      row :content do
        simple_format idea.content
      end
      row :votes
      row :slug
      row :commitment
      row :looking_for
      row :market
      row :image
      row :source
      row :video_url
      row :video_type
      row :created_at
      row :updated_at
    end
  end
  
end
