# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :book do
    sequence(:name) { |n| "Photography Ideas#{n}" }

    factory :book_with_ideas do
    	ignore do
    		ideas_count 12
    	end

    	after(:create) do |book, evaluator|
    		ideas = FactoryGirl.create_list(:idea, evaluator.ideas_count)
    		ideas.each do |idea|
    			book.ideas << idea
    		end
    	end
    end
  end
end
