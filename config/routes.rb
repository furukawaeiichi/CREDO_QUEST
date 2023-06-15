Rails.application.routes.draw do
  # Defines the root path route ("/")
  root "home#top"

  # Prefix Verb     URI Pattern     Controller#Action
  # HTTPリクエストメソッド      "パス",      to: "コントローラー名#アクション名"

  get "/home/top", to: "home#top"
  get "/home/special_thanks", to: "home#special_thanks"

  get "/auth/twitter2/callback", to: "sessions#create"
  get "/auth/failure", to: "sessions#failure"
  delete "/sign_out", to: "sessions#destroy"

  resources :users

  resources :lists do # ネスト(入れ子)されたリソースを定義
    resources :todos, only: [:update]
  end

  resources :tasks do
    resources :likes, only: [:create, :destroy]
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
