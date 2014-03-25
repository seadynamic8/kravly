comment = $('#comment-<%= @comment.id %>')
edit_link = comment.find('.edit-link')

if edit_link.find('.fi-page-edit').length > 0
	edit_link.text("Cancel")
	$('#comment-<%= @comment.id %> > .comment-text')
		.hide()
		.after('<%= j render "edit_body_form" %>')
else if edit_link.text() == "Cancel"
	edit_link.html("<i class=fi-page-edit></i>")
	comment.find('.comment-edit-form').remove()
	$('#comment-<%= @comment.id %> > .comment-text')
		.fadeIn()

