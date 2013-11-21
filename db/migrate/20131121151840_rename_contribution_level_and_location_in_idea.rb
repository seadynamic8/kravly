class RenameContributionLevelAndLocationInIdea < ActiveRecord::Migration
  def change
  	rename_column :ideas, :contribution_level, :commitment
  	rename_column :ideas, :location, :market
  end
end
