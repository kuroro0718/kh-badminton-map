class Account::MeetupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @meetups = current_user.meetups
  end
end
