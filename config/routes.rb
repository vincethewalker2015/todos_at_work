Rails.application.routes.draw do
  get 'pages/home'
  get 'todos/index'
  get 'todos/new'
  get 'todos/create'
  get 'todos/show'
  get 'todos/edit'
  get 'todos/update'
  get 'todos/destroy'
  root 'pages#home'
  resources :todos
end
