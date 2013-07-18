class RenameBooksIdeasToBoardsIdeas < ActiveRecord::Migration
  def change
  	rename_table :books_ideas, :boards_ideas
  end
end
