Rails.application.routes.draw do
  root "home#index"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/products", to: "products#index"
  get "/products/:id", to: "products#show", as: :product
end
