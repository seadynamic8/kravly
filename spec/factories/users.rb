require 'faker'

FactoryGirl.define do
  factory :user do
    #username { Faker::Internet.user_name }
    email { Faker::Internet.email }
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    password "test1234"
    password_confirmation "test1234"
    admin false

    factory :user_with_boards do

    	ignore do
    		boards_count 5
    	end

    	after(:create) do |user, evaluator|
    		FactoryGirl.create_list(:board, evaluator.boards_count, user: user)
    	end
    end

    factory :invalid_user do
        email nil
    end
  end
end
