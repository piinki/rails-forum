Rails.application.routes.draw do

  mount API => "/"

  scope "(:locale)", locale: /en|vi/ do
    devise_for :users, skip: [:sessions]
    as :user do
      get "signin", to: "sessions#new", as: :new_user_session
      post "signin", to: "sessions#create", as: :user_session
      delete "signout", to: "sessions#destroy", as: :destroy_user_session
      get "signup", to: "registrations#new"
    end
    root "demoui#home"

    # For admin panel

    namespace :managers do
      root "dashboard#index"
      resources :categories
    end

    # For demo ui

    get "demoui", controller: "demoui", action: "home"
    get "/demoui/index" => "demoui/index"
    get "/demoui/new" => "demoui/new"
    get "/demoui/show" => "demoui/show"
    get "/demoui/other" => "demoui/other"
  end
end
