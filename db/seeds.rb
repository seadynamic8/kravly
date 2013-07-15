# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Users.delete_all
users = [
	{ firstname: "Jarvis", lastname: "Kwan", username: "jkwan", email: "jkwan@example.com" },
	{ firstname: "Jovita", lastname: "Lai", username: "jlai", email: "jlai@example.com" },
	{ firstname: "Charles", lastname: "Lai", username: "clai", email: "clai@example.com" },
	{ firstname: "Jenny", lastname: "Yu", username: "jyyu", email: "jyyu@example.com" },
].each do |user|
	User.where(username: user[:username]).first_or_create!(user)
end