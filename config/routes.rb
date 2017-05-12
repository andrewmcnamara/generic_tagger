Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :entities, only: [:show, :destroy]

  post "/tag", to: "entities#tag"

  get "/stats", to: "stats#index"


end
