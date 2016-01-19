class BlocksController < ApplicationController

	def new
		@block = Block.new
	end

	def create
		@user = User.find(session[:user_id])
		@block = Block.new(block_params)
		@block.blocker_id = @user.registered_id
		if @block.save
			redirect_to(:controller => "notifications", :action => "index")
		else
			render("new")
		end
	end


	private

	def block_params
		params.require(:block).permit(:blockie_id)
	end

end
