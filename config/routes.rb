Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :posts do
    member do
      post :join
      post :quit
    end
  end
  root 'posts#index'
end
