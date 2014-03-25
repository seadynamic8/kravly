# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
	# Create a new comment
	$('.comment-form')
		.ajaxSend ->
			$(this).find('textarea')
				.attr('disabled', 'disabled')
		.on "ajax:success", (evt, data, status, xhr) ->
			$(this).find('textarea')
				.removeAttr('disabled', 'disabled')
				.val('')
			$(xhr.responseText)
				.hide()
				.appendTo($(this).parent())
				.show('slow')
			$('.empty-comments').hide()

	# Create a new reply comment
	$('.comments')
		.on "ajax:beforeSend", '.reply-form', (evt) ->
			$(this).find('textarea')
				.attr('disabled', 'disabled')

		.on "ajax:success", '.reply-form', (evt, data, status, xhr) ->
			$replyFormContainer = $(this)
			$comment = $(this).parent()

			$comment.find('.reply-link').text("reply")
			$replyFormContainer.removeClass("comment-reply-form")
			$replyFormContainer.find('form').remove()
			

			# replying to a root comment with a child comment
			#
			# if the comment has a child-comments div sibling,
			# append new comment to that child-comments div sibling
			if $comment.next('.child-comments').length
				$(xhr.responseText)
					.hide()
					.appendTo($comment.next('.child-comments'))
					.show 'slow'

			# replying to a child comment
			# 
			# if the comment is within a child-comments div (ie it is a child comment),
			# append new comment to that child-comments div
			else if $comment.parent('.child-comments').length
				$(xhr.responseText)
					.hide()
					.appendTo($comment.parent('.child-comments'))
					.show 'slow'

			# no child comments yet
			#
			# create child-comments div
			# append new comment to new child-comments div
			else
				$comment.after('<div class="child-comments"></div>')
				$(xhr.responseText)
					.hide()
					.appendTo($comment.next('.child-comments'))
					.show 'slow'



	# Delete a comment
  # $(document)
  #   .on "ajax:beforeSend", ".comment", ->
  #     $(this).fadeTo('fast', 0.5)
  #   .on "ajax:success", ".comment", ->
  #     $(this).hide('fast')
  #   .on "ajax:error", ".comment", ->
  #     $(this).fadeTo('fast', 1)