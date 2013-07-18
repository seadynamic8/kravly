class RenameBooksIdsIndexesToBoards < ActiveRecord::Migration
  def change
  	change_table :boards_ideas do |t|
  		t.rename :book_id, :board_id
  	end
  end
end
