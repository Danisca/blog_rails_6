Rails.application.routes.draw do
  get 'pages/home'
  root 'pages#home'
  resources 'articles'
  get 'signup', to: 'users#new'
  # post 'users', to: 'users#create'
  resources 'users', except: [:new]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'loguot', to: 'sessions#destroy'
end
