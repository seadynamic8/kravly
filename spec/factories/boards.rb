# == Schema Information
#
# Table name: boards
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#  description :string(255)
#  slug        :string(255)
#  category_id :integer
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :board do
    category
    user
    sequence(:name) { |n| "Photography Ideas#{n}" }

    factory :board_with_ideas do
    	ignore do
    		ideas_count 12
    	end

    	after(:create) do |board, evaluator|
    		ideas = FactoryGirl.create_list(:idea, evaluator.ideas_count, board: board)
    		# ideas.each do |idea|
    		# 	board.ideas << idea
    		# end
    	end
    end

    factory :invalid_board do
        name nil
    end
  end
end
