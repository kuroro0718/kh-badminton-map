class MeetupsController < ApplicationController
  before_action :find_params, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy, :join, :quit]

  def index    
    @meetups = Meetup.all
    if params[:search]
      @meetups = Meetup.search(params[:search]).order("created_at DESC")
    else
      @meetups = Meetup.all.order("created_at DESC")      
    end
  end

  def new
    @meetup = Meetup.new
  end 

  def show 
    @meetup = Meetup.friendly.find(params[:id])
    @hash = Gmaps4rails.build_markers(@meetup) do |meetup, marker|
      marker.lat meetup.latitude
      marker.lng meetup.longitude
    end   
  end

  def edit
  end

  def create    
    @meetup = current_user.meetups.create(meetup_params)
    @meetup.organizer = current_user
    
    if @meetup.save
      flash[:notice] = "新增球聚"
      redirect_to meetups_path
    else
      render :new
    end
  end 

  def update
    if @meetup.update(meetup_params)
      flash[:warning] = "修改完成"
      redirect_to meetup_path
    else
      render :edit
    end
  end

  def destroy
    @meetup.destroy

    flash[:alert] = "己刪除"
    redirect_to meetups_path
  end

  def join
    @meetup = Meetup.friendly.find(params[:id])    
    current_user.join!(@meetup) 

    flash[:notice] = "報名成功！"
    redirect_to meetup_path(@meetup)
  end

  def quit 
    @meetup = Meetup.friendly.find(params[:id])    
    current_user.quit!(@meetup) 

    flash[:notice] = "取消報名！"
    redirect_to meetup_path(@meetup) 
  end

  private

  def meetup_params
    params.require(:meetup).permit(:title, :address, :day, :comment, :image, :start_time, :end_time)
  end

  def find_params
    @meetup = current_user.meetups.friendly.find(params[:id])
  end
end
