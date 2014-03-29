module IdeasHelper

	def resource_checked?(looking_for, val)
		( val.blank? || looking_for.exclude?(val) ) ? "" : "checked"
	end

end
