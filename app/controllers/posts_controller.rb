class PostsController < ApplicationController

  before_action :find_post, :only => [:show, :edit, :update, :delete, :destroy]

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
    if @post.save
      redirect_to(:action => "index")
    else
      render("new")
    end
  end

  def edit
  end

  def update
    if @post.update_attributes(post_params)
      redirect_to(:action => "index")
    else
      render("edit")
    end
  end

  def delete
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

end
