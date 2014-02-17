class AddEmailNotificationPreferencesToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :notify_vote, :boolean, default: true
  	add_column :users, :notify_comment, :boolean, default: true
  end
end
