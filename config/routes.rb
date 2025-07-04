Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "pages#landing"

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  get "/dashboard", to: "dashboards#index"
  get "/learn_more", to: "pages#learn_more"
  get "/color_palette", to: "pages#color_palette"
  get "users/instructions", to: "users/instructions#instructions"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
