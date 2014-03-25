comment = $('#comment-<%= @comment.id %>')

# if comment has child comments, remove child comments
if comment.next('.child-comments').children().length
	comment.next('.child-comments')
		.fadeOut 'slow', ->
			$(this).remove()

# Remove comment
comment
	.fadeOut 'slow', ->
		$(this).remove()

		# show empty comments if no more comments
		$('.empty-comments').show() if $('.comment').length == 0

