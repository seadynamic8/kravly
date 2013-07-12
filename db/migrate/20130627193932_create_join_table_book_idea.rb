class CreateJoinTableBookIdea < ActiveRecord::Migration
  def change
    create_join_table :books, :ideas do |t|
      t.index [:book_id, :idea_id]
      t.index [:idea_id, :book_id]
    end
  end
end
