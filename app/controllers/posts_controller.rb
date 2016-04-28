class PostsController < ApplicationController
  before_action :find_params, only: [:edit, :update, :destroy, :show]
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy, :join]

  def index    
    @posts = Post.all
    if params[:search]
      @posts = Post.search(params[:search]).order("created_at DESC")
    else
      @posts = Post.all.order("created_at DESC")      
    end
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
    @post = current_user.posts.create(post_params)
    @post.organizer = current_user
    
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end 

  def update
    if @post.update(post_params)
      redirect_to post_path
    else
      render :edit
    end
  end

  def destroy
    @post.destroy

    redirect_to posts_path
  end

  def join
    @post = Post.friendly.find(params[:id])    
    current_user.join!(@post) 

    redirect_to post_path(@post)
  end

  def quit 
    @post = Post.friendly.find(params[:id])    
    current_user.quit!(@post) 

    redirect_to post_path(@post) 
  end

  private

  def post_params
    params.require(:post).permit(:title, :address, :day, :comment, :image)
  end

  def find_params
    @post = current_user.posts.friendly.find(params[:id])
  end
end
