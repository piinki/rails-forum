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
  patch "topics/:id/toggle_lock", to: "topics#toggle_lock", as: :topic_toggle_lock
  get "users/:id/ban", to: "users#viewban", as: :user_viewban
  patch "users/:id/ban", to: "users#ban", as: :user_ban
  patch "users/:id/unban", to: "users#unban", as: :user_unban
  patch "posts/:id/restore", to: "posts#restore", as: :post_restore
  resources :topics do
    resources :posts, shallow: true do
      member do
        get :upvote, :downvote
      end
      resources :history, controller: :history_posts
    end
  end

  resources :categories, only: %i(show)
  resources :inboxes
  resources :profile do
    collection do
      get "change_password", to: "profile#change_password"
      patch "change_password", to: "profile#update_change_password"
    end
  end

  # For admin panel
  namespace :managers do
    root "dashboard#index"
    resources :categories, shallow: true do
      resources :category_managers
    end

    resources :inboxes

    resources :users, except: :create do
      member do
        patch "ban"
        patch "unban"
        patch "restore"
      end
      collection do
        get "banned"
        get "deleted"
      end
    end
  end

  # For demo ui

  get "demoui", controller: "demoui", action: "home"
  get "/demoui/index" => "demoui/index"
  get "/demoui/new" => "demoui/new"
  get "/demoui/show" => "demoui/show"
  get "/demoui/other" => "demoui/other"
end
