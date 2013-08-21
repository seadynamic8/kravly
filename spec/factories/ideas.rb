require 'faker'

FactoryGirl.define do
  factory :idea do
    title { Faker::Company.name }
    content { Faker::Lorem.paragraphs(3).join(" ") }
    sequence(:votes) { |n| n }
    board

    # factory :idea_with_boards do
    # 	ignore do
    # 		boards_count 2
    # 	end

    # 	after(:create) do |idea, evaluator|
    # 		boards = FactoryGirl.create_list(:board, evaluator.boards_count)
    # 		boards.each do |board|
    # 			idea.boards << board
    # 		end
    # 	end
    # end
  end
end
