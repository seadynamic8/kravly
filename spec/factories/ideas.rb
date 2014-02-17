# == Schema Information
#
# Table name: ideas
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  content     :text
#  votes       :integer
#  created_at  :datetime
#  updated_at  :datetime
#  board_id    :integer
#  image       :string(255)
#  video_url   :string(255)
#  video_type  :string(255)
#  slug        :string(255)
#  commitment  :string(255)
#  source      :string(255)
#  looking_for :text
#  market      :string(255)
#

require 'faker'

FactoryGirl.define do
  factory :idea do
    board
    sequence(:title) { |n| "Idea-#{n}" }
    content { Faker::Lorem.paragraphs(3).join(" ") }
    sequence(:votes) { |n| n }
    #video_url { Faker::Internet.url }
    commitment "Founder/Co-Founder of New Company"
    
    # factory :idea_with_boards do
    # 	ignore do
    # 		boards_count 2
    # 	end

    # 	after(:create) do |idea, evaluator|
    # 		boards = FactoryGirl.create_list(:board, evaluator.boards_count)
    # 		boards.each do |board|
    # 			idea.boards << board
    # 		end
    # 	end
    # end

    factory :invalid_idea do
  		title nil
    end
  end
end
