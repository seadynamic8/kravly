module IdeasHelper

	def radio_checked?(val)
		logger.debug "val = #{val}"

		contribution = [ "Idea Producer Only", 
										 "Idea Producer and Product Designer", 
										 "Founder of New Company" ]

		( val.blank? || contribution.include?(val) ) ? "" : "checked"
	end
end
