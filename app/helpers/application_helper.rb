module ApplicationHelper

	def error_messages_for( object )
		render 'shared/error_messages', object: object
	end

	def title(page_title)
		content_for(:title) { h(page_title.to_s) }
	end

end
