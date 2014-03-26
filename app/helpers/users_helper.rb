module UsersHelper

	def mini_image(idea, path)
		if idea.nil?
			image_tag "http://img.kravly.com/board-mini-background.png"
		else
			link_to (image_tag idea.image.small_thumb.url), path
		end
	end
end
