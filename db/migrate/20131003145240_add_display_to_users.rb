class AddDisplayToUsers < ActiveRecord::Migration
  def change
    add_column :users, :display, :integer
  end
end
