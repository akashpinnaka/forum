class CommentsController < ApplicationController
  

	def create
		@comment = Comment.new(comment_params)
		@comment.save
		redirect_to(:controller => "posts", :action => "show", :id => @comment.post_id)    
	end





	private

	

	def comment_params
		params.require(:comment).permit(:answer, :post_id, :user_id)
	end



end