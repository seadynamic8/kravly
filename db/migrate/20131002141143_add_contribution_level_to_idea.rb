class AddContributionLevelToIdea < ActiveRecord::Migration
  def change
    add_column :ideas, :contribution_level, :string
  end
end
