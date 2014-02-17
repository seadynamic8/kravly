# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  username               :string(255)
#  email                  :string(255)
#  firstname              :string(255)
#  lastname               :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  password_digest        :string(255)
#  password_reset_token   :string(255)
#  password_reset_sent_at :datetime
#  avatar                 :string(255)
#  slug                   :string(255)
#  admin                  :boolean          default(FALSE)
#  about                  :text
#  location               :string(255)
#  website                :string(255)
#  display                :integer
#  notify_vote            :boolean          default(TRUE)
#  notify_comment         :boolean          default(TRUE)
#

require 'faker'

FactoryGirl.define do
  factory :user do
    # username { Faker::Internet.user_name }
    email { "aaa" + Faker::Internet.email }
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    password "test1234"
    password_confirmation "test1234"
    display 2
    admin false

    factory :user_with_boards do

    	ignore do
    		boards_count 5
    	end

    	after(:create) do |user, evaluator|
    		FactoryGirl.create_list(:board, evaluator.boards_count, user: user, category: create(:category))
    	end
    end

    factory :invalid_user do
      email nil
    end

    factory :admin do
      admin true
    end
  end
end
