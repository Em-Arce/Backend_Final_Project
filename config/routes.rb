Rails.application.routes.draw do
  devise_for :users
  root "static_pages#home"
  get "static_pages/welcome"
  resources :abstracts, only: [:index] #admin only
  resources :users do
      resources :abstracts, only: [:new, :create]
      resources :participations do
        get 'profile'
        resources :abstracts, only: [:show]
      end
  end
end
