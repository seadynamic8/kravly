class RemoveUserIdFromIdeas < ActiveRecord::Migration
  def change
  	remove_reference :ideas, :user
  end
end
