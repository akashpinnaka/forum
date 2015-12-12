class UsersController < ApplicationController

  layout "users"
  
  before_action :find_user, :only => [:show, :edit, :update, :delete, :destroy]
  before_action :check_role, :only => [:index, :new, :create]
  before_action :confirm_login, :except => [:login, :attempt_login]
  before_action :find_authorized_user_to_view_profile, :only => [:show]

 def index
  @users = User.where(:role => "student").order("created_at DESC")
 end

 def admins_list
   @admins = User.where(:role => "admin").order("created_at DESC")
 end

 def show
   
 end 

  def new
  	@user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to(:controller => "users", :action => "index")
    else
      render("new")
    end
  end

  def login
    if session[:user_id].present?
      redirect_to(:controller => "posts", :action => "index")
    else
      render("login")
    end
  end

  def attempt_login

    if params[:registered_id].present? && params[:password].present?
      found_user = User.where(:registered_id => params[:registered_id]).first
      if found_user
        authorized_user = found_user.authenticate(params[:password])
      end
    end

    if authorized_user
      session[:user_id] = authorized_user.id
      session[:registered_id] = authorized_user.registered_id
      session[:first_name] = authorized_user.first_name
      session[:last_name] =authorized_user.last_name
      session[:email] = authorized_user.email
      session[:role] = authorized_user.role
      session[:branch] = authorized_user.branch
      session[:profile_picture] = authorized_user.profile_picture
      redirect_to(:controller => "posts", :action => "index")
    else
      render("login")
    end

  end

  def logout
    session[:user_id] = nil
    redirect_to(:controller => "users", :action => "login")
  end

  def edit
  end

  def update

    if params[:user][:password].present?
      @user.validate_password = true
    else
      @user.validate_password = false
    end

    if @user.update_attributes(user_params)
      redirect_to(:controller => "users", :action => "show", :id => @user.id)
    else
      render("edit")
    end
  end

  def delete
  end

  def destroy
    @admins = User.where(:role => "admin").all
    if @user.role == "admin" && @admins.count < 2
      return false
    else
      @user.destroy
      redirect_to(:controller => "users", :action => "index")
    end
  end

  private

  def user_params
  	params.require(:user).permit(:registered_id, :first_name, :last_name, :email,
                                 :role, :branch, :password, :profile_picture)
  end

  def find_user
  	@user = User.find(params[:id])
  end
  
  def check_role
    if session[:role] == "admin"
      return true
    else
      redirect_to(:controller => "posts", :action => "index")
    end
  end

  def confirm_login
    if session[:user_id].present?
      return true
    else
      redirect_to(:controller => "users", :action => "login")
    end
  end

  def find_authorized_user_to_view_profile
    if session[:user_id] == @user.id || session[:role] == "admin"
      return true
    else
      redirect_to(:controller => "posts", :action => "index")
    end
  end

end
