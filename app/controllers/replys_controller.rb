class ReplysController < ApplicationController

	def create		
		@reply = Reply.new(reply_params)
		@reply.save
		sleep 1
		respond_to do |format|
			format.html {redirect_to(controller: "posts", action: "show", id: @reply.comment.post.id)}
			format.js
		end
	end

	private

	def reply_params
		params.require(:reply).permit(:content, :comment_id, :user_id)
	end

end
