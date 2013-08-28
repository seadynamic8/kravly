class AddPasswordDigestToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :password_digest, :string, index: true
  end
end
