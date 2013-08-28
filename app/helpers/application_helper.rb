module ApplicationHelper

	def error_messages_for( object )
		render 'shared/error_messages', object: object
	end
end
