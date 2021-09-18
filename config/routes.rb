Rails.application.routes.draw do
  devise_for :users
  root "static_pages#home"
  get 'static_pages/welcome'
  resources :abstracts, only: [:index, :destroy] #admin only
  resources :users do
    resources :abstracts, only: [:new, :show, :create, :update]
  end
end
