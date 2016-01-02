class NotificationsController < ApplicationController

    layout "posts"

	def index
		@notifications = Notification.where(:recipient_id => session[:registered_id]).order("created_at DESC")

	end

	def new
		@user = User.find(session[:user_id])
		@notification = @user.notifications.new
	end

	def create
		@user = User.find(session[:user_id])
		@notification = @user.notifications.new notification_params
		if @notification.save
			redirect_to(:controller => "posts", :action => "index")
		else
			render "new"
		end
	end

	private

	def notification_params
		params.require(:notification).permit(:message, :user_id, :recipient_id)
	end

end
