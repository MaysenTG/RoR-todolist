Rails.application.routes.draw do
  devise_for :users
  resources :todos
  get 'home/about'
  root 'todos#index'
  get "*path", to: redirect('/'), notice: "Page not found"
  
end