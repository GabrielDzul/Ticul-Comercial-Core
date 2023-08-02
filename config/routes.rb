Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :app, defaults: { format: 'json' } do

    # ==================================
    # Sign Up
    #   - PUT  /app/sign_up
    # ==================================
    resource :sign_up, only: %i[create], controller: :sign_up do
    end
  end
end
