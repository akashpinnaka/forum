class PostsController < ApplicationController

  layout "posts"

  before_action :find_post, :only => [:show, :edit, :update, :delete, :destroy]
  before_action :confirm_login

  def index
    @posts = Post.all.order("created_at DESC")   
  end

  def show
    @comment = Comment.new
    
    @comments = Comment.order("created_at DESC").where(:post_id => @post.id)
    
  end

  def new
      @post = Post.new 
  end

  def create
    @post = Post.new(post_params)  
    @post.user_id = session[:user_id]
    if @post.save
      redirect_to(:action => "show", :id => @post.id)
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
      respond_to do |format|
        format.html {redirect_to(:action => "index")}
        format.js
      end
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

  def upvote
    @post = Post.find(params[:id])
    @post.upvote_from User.find(session[:user_id])
    respond_to do |format|
      format.html {redirect_to(:controller => "posts", :action => "show", :id => @post.id)}
      format.js
    end
  end

  def downvote
    @post = Post.find(params[:id])
    @post.downvote_from User.find(session[:user_id])
    respond_to do |format|
      format.html {redirect_to(:controller => "posts", :action => "show", :id => @post.id)}
      format.js
    end
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
