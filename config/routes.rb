Rails.application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"
  mount API => "/"

  devise_for :users, skip: [:sessions]
  as :user do
    get "signin", to: "sessions#new", as: :new_user_session
    post "signin", to: "sessions#create", as: :user_session
    delete "signout", to: "sessions#destroy", as: :destroy_user_session
    get "signup", to: "registrations#new"
  end

  root "topics#index"

  patch "topics/:id/pin", to: "topics#pin", as: :topic_pin
  patch "topics/:id/unpin", to: "topics#unpin", as: :topic_unpin

  resources :topics do
    resources :posts
  end

  resources :categories, only: %i(show)

  resources :profile do
    collection do
      get "change_password", to: "profile#change_password"
      patch "change_password", to: "profile#update_change_password"
    end
  end

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
