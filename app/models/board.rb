# == Schema Information
#
# Table name: boards
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

class Board < ActiveRecord::Base

	belongs_to :user
	has_many :ideas, dependent: :destroy

	validates :name, presence:true, uniqueness: true, length: { maximum: 255 }

end
