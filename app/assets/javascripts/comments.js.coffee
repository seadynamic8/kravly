# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
	# Create a comment
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
				# .before('<div class="comment" id="comment-<%= root_comment.id %>" data-no-turbolink>')
				.after('</div>')
				.insertAfter($(this).parent())
				.show('slow')
			$('.empty-comments').hide()

$(document)
	.on "ajax:beforeSend", '.reply-form', (evt) ->
		$(this).find('textarea')
			.attr('disabled', 'disabled')
	.on "ajax:success", '.reply-form', (evt, data, status, xhr) ->
		$(this).parent().find('.reply-link').text("Reply")
		$(this).removeClass("reply-form-style")
		$(this).find('form').remove()

		# replying to a root comment with a child comment
		if $(this).next('.child-comments').length
			$(xhr.responseText)
				.hide()
				.after('</div>')
				.appendTo($(this).next('.child-comments'))
				.show 'slow'
		 # replying to a child comment
		else if $(this).parent().parent('.child-comments').length
			$(xhr.responseText)
				.hide()
				.after('</div>')
				.appendTo($(this).parent().parent('.child-comments'))
				.show 'slow'
		else # no child comments yet
			$(this).after('<div class="child-comments"></div>')
			$(xhr.responseText)
				.hide()
				.after('</div>')
				.appendTo($(this).next('.child-comments'))
				.show 'slow'

	# Delete a comment
  # $(document)
  #   .on "ajax:beforeSend", ".comment", ->
  #     $(this).fadeTo('fast', 0.5)
  #   .on "ajax:success", ".comment", ->
  #     $(this).hide('fast')
  #   .on "ajax:error", ".comment", ->
  #     $(this).fadeTo('fast', 1)