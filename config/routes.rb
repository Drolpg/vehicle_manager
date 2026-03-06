Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  resources :cars
  resources :motorcycles
  resources :vehicles, only: [ :index ]
  resources :rentals, only: [ :new, :create, :show ]

  root "vehicles#index"
end
