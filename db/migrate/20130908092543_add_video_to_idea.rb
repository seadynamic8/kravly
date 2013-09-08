class AddVideoToIdea < ActiveRecord::Migration
  def change
    add_column :ideas, :video_url, :string
    add_column :ideas, :video_type, :string
  end
end
