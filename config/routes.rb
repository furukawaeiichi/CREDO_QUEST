Rails.application.routes.draw do
  # Defines the root path route ("/")
  root "home#top"

  get "home/top", to: "home#top"
  get "home/special_thanks", to: "home#special_thanks"

  get "/auth/:provider/callback", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
