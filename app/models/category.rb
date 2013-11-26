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

class Category < ActiveRecord::Base

	has_many :boards

	include FriendlyId
	friendly_id :name, use: [:slugged]

	normalize_attributes :name

	validates :name, presence: true, uniqueness: true

	scope :sorted, -> { order("name asc") }

	after_validation :move_friendly_id_error_to_name

	def should_generate_new_friendly_id?
		nil? || new_record? || name.blank? || name_changed?
	end

	private

		def move_friendly_id_error_to_name
			errors.add :name, *errors.delete(:friendly_id) if errors[:friendly_id].present?
		end
end
