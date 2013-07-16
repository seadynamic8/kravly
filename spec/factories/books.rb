# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :book do
    sequence(:name) { |n| "Photography Ideas#{n}" }
  end
end
