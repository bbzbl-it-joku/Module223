Rails.application.routes.draw do
  get "chats/index"
  get "chats/create"
  get "chats/destroy"
  get "chats/index"
  get "chats/create"
  root "pages#home"
  get "about", to: "pages#about"
  get "error", to: "pages#error"

  resources :users
  resources :clubs do
    member do
      get 'edit_members'
      post "join"
      delete "leave"
    end
    resources :club_members, only: [:create, :update, :destroy]
    resources :reading_list_books, only: [:create, :update, :destroy]
    resources :chats, only: [:index, :create, :destroy] do
      get 'load_more', on: :collection
    end
  end
  resources :books do
    resources :reviews
  end

  get "signup", to: "users#new"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  get "change_password", to: "passwords#edit", as: "edit_password"
  patch "change_password", to: "passwords#update", as: "update_password"

  get "confirm_email/:confirmation_token", to: "users#confirm_email", as: "confirm_email"
  post "resend_confirmation", to: "users#resend_confirmation"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
