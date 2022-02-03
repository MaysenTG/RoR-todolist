Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  resources :todos
  
  get 'search', to: 'todos#search'
  
  get 'home/about'
  root 'todos#index'
  get "*path", to: redirect('/'), notice: "Page not found"
  
end