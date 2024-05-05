Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :admin do
    resources :authors
    resources :books
    resources :users
    resources :borrowers
    root "home#index"
  end

  resources :users, except: [:new, :create]

  get "sign_in" => "users#sign_in", as: :sign_in
  post "sign_in_validation" => "users#sign_in_validation", as: :sign_in_validation

  get "sign_up" => "users#sign_up", as: :sign_up
  post "sign_up_validation" => "users#sign_up_validation", as: :sign_up_validation

  get "request_book" => "home#request_book", as: :request_book
  get "show/:id" => "home#show", as: :show_book

  get "log_out" => "users#log_out", as: :log_out

  # Defines the root path route ("/")
  root "home#index"
end
