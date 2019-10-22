Rails.application.routes.draw do

  get 'users/new'
  get 'users/create'
  root 'pages#home'
  resources :users
  resources :todos
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/login', to: 'sessions#destroy'
end
