Rails.application.routes.draw do
  resources :training_plans

  root to: "home#index"

  get "dashboard", to: 'dashboard#show', as: :dashboard, constraints: Routes::LoggedInConstraint.new

  devise_for :users
end
