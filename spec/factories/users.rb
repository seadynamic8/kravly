require 'faker'

FactoryGirl.define do
  factory :user do
    username { Faker::Internet.user_name }
    email { Faker::Internet.email }
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }

    factory :user_with_books do

    	ignore do
    		books_count 5
    	end

    	after(:create) do |user, evaluator|
    		FactoryGirl.create_list(:book, evaluator.books_count, user: user)
    	end
    end
  end
end
