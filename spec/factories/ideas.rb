require 'faker'

FactoryGirl.define do
  factory :idea do
    title { Faker::Company.name }
    content { Faker::Lorem.paragraphs(3).join(" ") }
    sequence(:votes) { |n| n }

    factory :idea_with_books do
    	ignore do
    		books_count 2
    	end

    	after(:create) do |idea, evaluator|
    		books = FactoryGirl.create_list(:book, evaluator.books_count)
    		books.each do |book|
    			idea.books << book
    		end
    	end
    end
  end
end
