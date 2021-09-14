Rails.application.routes.draw do
  root 'pages#home'
  get 'about' , to: 'pages#about'
  resources :contacts, only: [:show, :index, :new, :create]
end
