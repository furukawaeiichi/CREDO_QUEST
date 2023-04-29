Rails.application.routes.draw do
  # Defines the root path route ("/")
  root "home#top"

  get 'home/top'
  get 'home/special_thanks'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
