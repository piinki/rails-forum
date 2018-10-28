Rails.application.routes.draw do

  mount API => '/'

  scope "(:locale)", locale: /en|vi/ do
    devise_for :users, controllers: {sessions: "sessions"}
    root "demoui#home"

    # For admin panel

    namespace :managers do
      root "dashboard#index"
    end

    # For demo ui

    get "demoui", controller: "demoui", action: "home"
    get "/demoui/index" => "demoui/index"
    get "/demoui/new" => "demoui/new"
    get "/demoui/show" => "demoui/show"
    get "/demoui/other" => "demoui/other"
  end
end
