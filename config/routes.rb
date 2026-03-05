Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  resources :cars
  resources :motorcycles
  resources :vehicles, only: [ :index ]

  root "vehicles#index"
end
