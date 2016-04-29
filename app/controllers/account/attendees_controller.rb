class Account::AttendeesController < ApplicationController
  before_action :authenticate_user!

  def index
    @meetups = current_user.participated_meetups
  end
end
