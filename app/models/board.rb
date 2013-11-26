# == Schema Information
#
# Table name: boards
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#  description :string(255)
#  slug        :string(255)
#  category_id :integer
#

class Board < ActiveRecord::Base

	belongs_to :category
	belongs_to :user
	has_many :ideas, dependent: :destroy

	include FriendlyId
	friendly_id :name, use: [:slugged, :history]

	normalize_attributes :name, :description

	validates :name, presence: true, uniqueness: { scope: :user }, length: { maximum: 30 }
	validates :description, length: { maximum: 255 }
	validates :user_id, presence: true
	validates :user, associated: true
	validates :category_id, presence: true
	validates :category, associated: true

	scope :recent, -> { order("created_at desc") }

	after_validation :move_friendly_id_error_to_name

	def votes
		ideas.inject(0) { |total, idea| total + idea.votes }
	end

	def should_generate_new_friendly_id?
		new_record? || name.blank? || name_changed?
	end

	private

		def move_friendly_id_error_to_name
			errors.add :name, *errors.delete(:friendly_id) if errors[:friendly_id].present?
		end

end
