class CommentsController < ApplicationController

	def create
		@comment_hash = params[:comment]
		@obj = @comment_hash[:commentable_type].constantize.find(@comment_hash[:commentable_id])
		# Not implemented: check to see whether the user has permission to create a comment on this object
		@comment = Comment.build_from(@obj, current_user.id, @comment_hash[:body])
		logger.debug "\n****Comment: #{@comment.inspect}\n"
		if @comment.save
			render partial: 'comments/comment', locals: { comment: @comment }, 
						layout: false, status: :created
		else
			render js: "alert('error saving comment')" #Temporary
		end
	end

	def edit
		@comment = Comment.find(params[:id])
	end

	def update
		@comment = Comment.find(params[:id])
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
		@comment = Comment.find(params[:id])
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

	private

		def comment_params
			params.require(:comment).permit(:body)
		end
end
