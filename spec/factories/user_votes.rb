# == Schema Information
#
# Table name: user_votes
#
#  id         :integer          not null, primary key
#  idea_id    :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_vote do
    idea 1
    user_id 1
  end
end
