comment = $('#comment-<%= @comment.id %>')

if comment.parent('.child-comments').children().length == 1
	comment.parent('.child-comments')
		.fadeOut 'slow', ->
			$(this).remove()
else
	comment
		.fadeOut 'slow', ->
			$(this).remove()
			$('.empty-comments').show() if $('.comment').length == 0

