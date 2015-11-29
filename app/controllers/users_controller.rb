class UsersController < ApplicationController


 def show
   
 end 

  def new
  	
  end

  def create
  	
  end

  def login
  end

  def attempt_login
  
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
