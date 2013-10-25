class CommentsController < ApplicationController
	before_action :current_resource, only: [:edit, :update, :destroy, :reply]

	def create
		if params[:comment]
			@comment_hash = params[:comment]
		else
			@comment_hash = params[:reply_comment]
		end
		idea = Idea.find(@comment_hash[:idea_id])
		@new_comment = Comment.build_from(idea, nil, "")
		@obj = @comment_hash[:commentable_type].constantize.find(@comment_hash[:commentable_id])
		# Not implemented: check to see whether the user has permission to create a comment on this object
		@comment = Comment.build_from(@obj, current_user.id, @comment_hash[:body])

		if @comment.save
			if @comment_hash[:comment_id].present?
				parent_comment = Comment.find(@comment_hash[:comment_id])
				parent_comment = parent_comment.parent if parent_comment.parent
				@comment.move_to_child_of(parent_comment)

				render partial: 'comments/child_comment', locals: { child_comment: @comment, 
							idea_id: idea.id, reply_comment: @new_comment }, 
							layout: false, status: :created
			else
				render partial: 'comments/comment', locals: { comment: @comment, 
							child_comments: nil,
							idea_id: idea.id, reply_comment: @new_comment }, 
							layout: false, status: :created
			end
		else
			render js: "alert('Comment cannot be blank');
									$('.comment-form').find('input.button')
										.removeAttr('disabled', 'disabled')
										.val('Comment');" #Temporary
		end
	end

	def edit
	end

	def update
		if @comment.update_attributes(comment_params)
			respond_to do |format|
				format.html { redirect_to @comment.commentable }
				format.js
			end
		else
			render js: "alert('error updating comment')" #Temporary
		end
	end

	def destroy
		if @comment.destroy
			respond_to do |format|
				format.html { redirect_to @comment.commentable }
				format.js
			end
			# render json: @comment, status: :ok
		else
			render js: "alert('error deleting comment');" #Temporary
		end
	end

	def reply
		@idea = Idea.friendly.find(params[:idea_id])
		@reply_comment = Comment.build_from(@idea, nil, "")
	end

	private

		def current_resource
			@comment = Comment.find(params[:id]) if params[:id]
		end

		def comment_params
			params.require(:comment).permit(:body)
		end
end
