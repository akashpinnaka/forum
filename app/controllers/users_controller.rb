class UsersController < ApplicationController


 def show
   @user = User.find(params[:id])
 end 

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		redirect_to(:controller => "users", :action => "show", :id => @user.id)
  	else
  		render("new")
  	end
  end

  def login
  end

  def attempt_login
    if params[:registered_id] && params[:password]
      found_user = User.where(:registered_id => params[:registered_id]).first
        if found_user
          authorized_user = found_user.authenticate(params[:password])
        end
    end
    if authorized_user
      session[:user_id] = authorized_user.id
      redirect_to(:controller => "posts", :action => "index")
    end
  end


  private

  def user_params
  	params.require(:user).permit(:registered_id, :first_name, :last_name, :email, :role, :password)
  end

  def find_user
  	@user = User.find(params[:id])
  end

  def current_user
  	current_user = User.find(:session[:id])
  end

end
