Rails.application.routes.draw do
  root to: 'homepages#index'

  resources :works
  
  # resources :trips, except: [:index, :new, :create]
end
