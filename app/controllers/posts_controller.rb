class PostsController < ApplicationController

  before_action :find_post, :only => [:show, :edit, :update, :delete, :destroy]
  before_action :confirm_login

  def index
    @posts = Post.all.order("created_at DESC")   
  end

  def show
  end

  def new
      @post = Post.new 
  end

  def create
    @post = Post.new(post_params)  
    @post.user_id = session[:user_id]
    if @post.save
      redirect_to(:action => "index")
    else
      render("new")
    end
  end

  def edit
    if @post.user_id == session[:user_id]
      render("edit")
    else
      redirect_to(:controller => "posts", :action => "index")
    end
  end

  def update

    @post.user_id = session[:user_id]
    if @post.update_attributes(post_params)
      redirect_to(:action => "index")
    else
      render("edit")
    end
  end

  def delete
    if @post.user_id == session[:user_id]
      render("delete")
    else
      redirect_to(:controller => "posts", :action => "index")
    end
  end

  def destroy
    @post.destroy
    redirect_to(:action => "index")
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def confirm_login
    if session[:user_id].present?
      return true
    else
      redirect_to(:controller => "users", :action => "login")
    end
  end
  
end
