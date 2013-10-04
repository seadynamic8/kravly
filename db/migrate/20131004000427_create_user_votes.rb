class CreateUserVotes < ActiveRecord::Migration
  def change
    create_table :user_votes do |t|
      t.integer :idea_id
      t.integer :user_id

      t.timestamps
    end
    add_index :user_votes, :idea_id
    add_index :user_votes, :user_id
  end
end