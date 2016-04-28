class MeetupsController < ApplicationController
  before_action :find_params, only: [:edit, :update, :destroy, :show]
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy, :join]

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
      redirect_to meetups_path
    else
      render :new
    end
  end 

  def update
    if @meetup.update(meetup_params)
      redirect_to meetup_path
    else
      render :edit
    end
  end

  def destroy
    @meetup.destroy

    redirect_to meetups_path
  end

  def join
    @meetup = Meetup.friendly.find(params[:id])    
    current_user.join!(@meetup) 

    redirect_to meetup_path(@meetup)
  end

  def quit 
    @meetup = Meetup.friendly.find(params[:id])    
    current_user.quit!(@meetup) 

    redirect_to meetup_path(@meetup) 
  end

  private

  def meetup_params
    params.require(:meetup).permit(:title, :address, :day, :comment, :image)
  end

  def find_params
    @meetup = current_user.meetups.friendly.find(params[:id])
  end
end
