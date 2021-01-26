Rails.application.routes.draw do
  get 'pages/home'
  root 'pages#home'
  resources 'articles'
  get 'signup', to: 'users#new'
  # post 'users', to: 'users#create'
  resources 'users', except: [:new]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
