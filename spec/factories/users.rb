# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    username "jsmith"
    sequence(:email)  { |n| "jsmith#{n}@example.com" }
    firstname "Joe"
    lastname "Smith"
  end
end
