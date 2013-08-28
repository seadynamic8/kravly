# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :board do
    sequence(:name) { |n| "Photography Ideas#{n}" }

    factory :board_with_ideas do
    	ignore do
    		ideas_count 12
    	end

    	after(:create) do |board, evaluator|
    		ideas = FactoryGirl.create_list(:idea, evaluator.ideas_count)
    		ideas.each do |idea|
    			board.ideas << idea
    		end
    	end
    end

    factory :invalid_board do
        name nil
    end
  end
end
