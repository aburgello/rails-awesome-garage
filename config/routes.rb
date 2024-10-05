Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

# Defines the root path route ("/")
# Root route
root "cars#index"

# Car resources
resources :cars do
  resources :reviews
  resources :favourites, only: [ :create, :destroy ]
  collection do
    get "models"
  end
end

# Battles resources
resources :battles, only: [ :index, :create ] do
  collection do
    get "new_cars", to: "battles#new_cars"
    post "vote/:id", to: "battles#vote", as: "vote_battle"
  end
end

# Aliased routes
get "car_battle", to: "battle#index", as: "car_battle"
get "battles/new_cars", to: "battle#new_cars"

# Favourites resources
resources :favourites, only: [ :index ]

# Pick a car
get "pick_a_car", to: "cars#pick"
end
