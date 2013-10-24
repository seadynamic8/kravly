edit_link = $('#comment-<%= @comment.id %> > .edit-comment')
edit_link_text = edit_link.text()

if edit_link_text == "Edit"
	edit_link.text("Cancel")
	$('#comment-<%= @comment.id %> > .comment-text')
		.hide()
		.after('<%= j render "edit_body_form" %>')
else if edit_link_text == "Cancel"
	edit_link.text("Edit")
	$('.edit-comment-form').remove()
	$('#comment-<%= @comment.id %> > .comment-text')
		.fadeIn()

