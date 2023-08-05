Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :app, defaults: { format: 'json' } do

    # ==================================
    # Sign Up
    #   - PUT  /app/sign_up
    # ==================================
    resource :sign_up, only: %i[create], controller: :sign_up

    # ==================================
    # Users
    #   - GET  /app/users/activate
    #   - POST /app/users
    # ==================================
    resources :users, only: %i[create] do
      collection do
        get :activate
      end
    end
  end

  resource :misc, only: [], controller: :miscellaneous do
    get :welcome
  end

  # ==================================
  # Dev utilities
  # ==================================
  unless Rails.env.production?
    # ==================================
    # API Docs
    #   - GET     /docs/app
    # ==================================
    resources :docs, only: [:index] do
      collection do
        get :app
      end
    end
  end
end
