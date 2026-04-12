Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  devise_for :users
  resource :profile, only: [ :show ], controller: "profiles"

  resources :tags
  resources :steps
  resources :recipes do
    member do
      get :add_ingredient
      post :create_ingredient

      get :add_step
      post :create_step
    end
  end

  resources :ingredients
  resources :categories
  resources :ingredient_recipes

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#index"

  # Dashboard widget endpoints
  scope controller: :home do
    get "home", action: :index, as: :home_index
    get "home/top_widgets", action: :top_widgets, as: :home_top_widgets
    get "home/latest_recipes", action: :latest_recipes, as: :home_latest_recipes
    get "home/ingredient_tags", action: :ingredient_tags, as: :home_ingredient_tags
    get "home/recipe_tags", action: :recipe_tags, as: :home_recipe_tags
    get "home/top_cuisines", action: :top_cuisines, as: :home_top_cuisines
  end
end
