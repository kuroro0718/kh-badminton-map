class PostsController < ApplicationController
  before_action :find_params, only: [:show, :edit, :update, :destroy]

  def index    
    @posts = Post.all
  end

  def new
    @post = Post.new
  end 

  def show 
    @hash = Gmaps4rails.build_markers(@post) do |post, marker|
      marker.lat post.latitude
      marker.lng post.longitude
    end   
  end

  def edit
  end

  def create    
    @post = Post.create(post_params)
    
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end 

  def update
    if @post.update(post_params)
      redirect_to posts_path
    else
      render :edit
    end
  end

  def destroy
    @post.destroy

    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :address, :day, :comment)
  end

  def find_params
    @post = Post.find(params[:id])
  end
end
