Rails.application.routes.draw do
  # Defines the root path route ("/")
  root "home#top"

  get "home/top", to: "home#top"
  get "home/special_thanks", to: "home#special_thanks"

  get "/auth/:provider/callback", to: "sessions#create"
  get "/auth/failure", to: "sessions#failure"
  delete "/sign_out", to: "sessions#destroy"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
