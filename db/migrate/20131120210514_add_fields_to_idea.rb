class AddFieldsToIdea < ActiveRecord::Migration
  def change
    add_column :ideas, :looking_for, :text
    add_column :ideas, :location, :string
  end
end
