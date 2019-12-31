Rails.application.routes.draw do

  root 'pages#home'
  get 'users/new'
  get 'users/create'
  resources :users
  resources :todos do
    resources:comments, only: [:create]
  end
  resources :owners
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/login', to: 'sessions#destroy'

  mount ActionCable.server => '/cable'
  get '/chat', to: 'chatrooms#show'
  resources :messages, only: [:create]
end
