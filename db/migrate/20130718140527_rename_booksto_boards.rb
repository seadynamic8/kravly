class RenameBookstoBoards < ActiveRecord::Migration
  def change
  	rename_table :books, :boards
  end
end
