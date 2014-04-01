module ApplicationHelper

	def error_messages_for( object )
		render 'shared/error_messages', object: object
	end

	def title(page_title)
		content_for(:title) { h(page_title.to_s) }
	end

	def page
		content_for(:page) {
			"#{params[:controller]}-#{params[:action]}-page"
		}
	end

	def action_new_create?
		params[:action] == 'new' || params[:action] == 'create'
	end

	def action_edit_update?
		params[:action] == 'edit' || params[:action] == 'update'
	end

end
