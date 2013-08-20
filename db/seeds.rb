# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

#Idea.delete_all
# ideas = [
# 	{ title: "Happy Feet Yoga", content: "<p>THIS is a line of products surrounding the Miswak, an ancient tooth-cleaning twig still used in several countries around the world. The collection starts with a carrying case designed to help Miswak-users cut and peel the bark around the stick on-the-go. We are also working on creating interchangeable caps that serve different purposes, like cleaning, cutting and softening the bristles.

# THIS started off as a student project at the School of Visual Arts in NYC, but quickly gained a lot of interest from press and individuals around the world who were excited about a modernized version of this age-old tradition.

# We're currently a small team working on revisiting the design of the original carrying case, coming up with new ideas for the line, and seeking out like-minded manufacturers and suppliers.

# Looking forward to your feedback, and feel free to sign up for updates about the project here.</p>", votes: 97 },
# 	{ title: "What is Lorem Ipsum?", content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", votes: 45 },
# 	{ title: "Why do we use it?", content: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).", votes: 32 },
# 	{ title: "Where does it come from?", content: "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32.", votes: 29 },
# 	{ title: "Where can I get some?", content: "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.", votes: 18 },
# ].each do |idea|
# 	Idea.where(title: idea[:title]).first_or_create!(idea)
# end

# ideas = []
# 336.times do
# 	ideas << { title: Faker::Company.name, content: Faker::Lorem.paragraphs(3).join("<br/>"), votes: rand(1..100) }
# end
# ideas.each do |idea|
# 	i = Idea.where(title: idea[:title]).first_or_create!(idea)
# 	b = Board.offset(rand(Board.count)).first
# 	i.boards << b
# end

# Board.delete_all
# boards = []
# 28.times do
# 	boards << { name: Faker::Company.name, user_id: rand(1..4) }
# end
# boards.each do |board|
# 	Board.where(name: board[:name]).first_or_create!(board)
# end

#Users.delete_all
# users = [
# 	{ firstname: "Jarvis", lastname: "Kwan", username: "jkwan", email: "jkwan@example.com" },
# 	{ firstname: "Jovita", lastname: "Lai", username: "jlai", email: "jlai@example.com" },
# 	{ firstname: "Charles", lastname: "Lai", username: "clai", email: "clai@example.com" },
# 	{ firstname: "Jenny", lastname: "Yu", username: "jyyu", email: "jyyu@example.com" },
# ].each do |user|
# 	User.where(username: user[:username]).first_or_create!(user)
# end

# ideas = Idea.all
# ideas.each do |idea|
# 	idea.user_id = idea.boards.first.user_id
# 	idea.save
# end