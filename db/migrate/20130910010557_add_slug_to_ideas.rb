class AddSlugToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas, :slug, :string
    add_index :ideas, :slug
  end
end
