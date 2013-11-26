require 'faker'

FactoryGirl.define do
  factory :category do
    sequence(:name ) { |n| "Category-#{n}" }

    factory :invalid_category do
    	name nil
    end
  end
end
