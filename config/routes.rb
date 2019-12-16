Rails.application.routes.draw do

  get 'users/new'
  get 'users/create'
  root 'pages#home'
  resources :users
  resources :todos do
    resources:comments, only: [:create]
  end
  resources :owners
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/login', to: 'sessions#destroy'

  mount ActionCable.server => '/cable'
end
