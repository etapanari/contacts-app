Rails.application.routes.draw do
  root to: 'contacts#index'

  resources :contacts do 
    member do
      get "changes", to: "contacts#changes"
    end
  end
end
