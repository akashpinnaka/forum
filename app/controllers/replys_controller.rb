class ReplysController < ApplicationController

	def create		
		@reply = Reply.new(reply_params)
		@reply.save
		redirect_to(:controller => "posts", :action => "show", :id => @reply.comment.post.id)    
	end



	private

	

	def reply_params
		params.require(:reply).permit(:content, :comment_id, :user_id)
	end

end
