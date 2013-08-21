class AddBoardIdToIdeas < ActiveRecord::Migration
  def change
  	add_reference :ideas, :board, index: true
  end
end
