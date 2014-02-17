# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  slug       :string(255)
#

require 'faker'

FactoryGirl.define do
  factory :category do
    sequence(:name ) { |n| "Category-#{n}" }

    factory :invalid_category do
    	name nil
    end
  end
end
