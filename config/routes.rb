Rails.application.routes.draw do
  devise_for :admins
  devise_for :users

  resources :cars
  resources :motorcycles

  resources :vehicles, only: [ :index ] do
    resources :rentals, only: [ :new, :create ]
  end

  resources :rentals, only: [ :show ] do
    collection do
      get :my_rentals
    end
  end

  root "vehicles#index"
end
