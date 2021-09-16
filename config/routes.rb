Rails.application.routes.draw do
  devise_for :users
  root "static_pages#home"
  get 'static_pages/welcome'
  resources :users
  resources :abstracts
end
