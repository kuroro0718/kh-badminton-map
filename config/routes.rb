Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :meetups do
    member do
      post :join
      post :quit
    end
  end

  namespace :account do
    resources :meetups
    resources :attendees
  end
  root 'meetups#index'
end
