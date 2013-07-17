require 'faker'

FactoryGirl.define do
  factory :idea do
    title { Faker::Company.name }
    content { Faker::Lorem.paragraphs(3).join(",") }
    sequence(:votes) { |n| n }
  end
end
