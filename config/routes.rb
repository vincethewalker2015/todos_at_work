Rails.application.routes.draw do

  get 'users/new'
  get 'users/create'
  root 'pages#home'
  resources :users
  resources :todos
end
