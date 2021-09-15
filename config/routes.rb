Rails.application.routes.draw do
  root 'pages#home'
  #get 'about' , to: 'pages#about'
  resources :contacts do #, only: [:show, :index, :new, :create, :edit, :update, :destroy, :audits]
    member do
      get "changes", to: "contacts#changes"
    end
  end
end
