Rails.application.routes.draw do
  resources :cars
  resources :motorcycles
  resources :vehicles, only: [ :index ]

  root "vehicles#index"
end
