Rails.application.routes.draw do
  devise_for :users
  root "static_pages#home"
  get 'static_pages/welcome'
  resources :abstracts, only: [:index, :destroy] #admin only
  resources :users do
      resources :abstracts, only: [:new, :create]
      resources :participations do
        resources :abstracts, only: [:show, :edit, :update]
      end
  end
end
