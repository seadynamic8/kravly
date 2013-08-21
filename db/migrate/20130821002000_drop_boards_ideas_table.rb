class DropBoardsIdeasTable < ActiveRecord::Migration
  def change
  	drop_table :boards_ideas
  end
end
