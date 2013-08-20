class AddForeignKeytoIdea < ActiveRecord::Migration
  def change
  	add_reference :ideas, :user, index: true
  end
end
