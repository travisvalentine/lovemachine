Lovemachine::Application.routes.draw do

  get "/signin", to: "sessions#new", as: "signin"
  post "/signin", to: "sessions#create"
  get "/signout", to: "sessions#destroy", as: "signout"

  namespace :admin do
    root "base#index"
    resources :users
  end

  resources :users
  resources :tags, only: [:show, :index, :create]
  resources :user_tags, only: [:create, :destroy]
  get '', to: 'tags#show', constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' }
  root "tags#index"

  resources :tweets, only: [:index]

end
