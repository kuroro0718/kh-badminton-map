class PostsController < ApplicationController
  before_action :find_params, only: [:show]
  
  def index    
    @posts = Post.all
  end

  def new
    @post = Post.new
  end 

  def show    
  end

  def create    
    @post = Post.create(post_params)
    
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end 

  private

  def post_params
    params.require(:post).permit(:title, :location, :day, :comment)
  end

  def find_params
    @post = Post.find(params[:id])
  end
end
