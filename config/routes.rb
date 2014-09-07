Rails.application.routes.draw do

  resources :training_plans, path: 'training-plans' do
    resources :workout_plans, path: 'workouts'

    get 'week/:week/day/:day', to: 'workout_plans#show'
  end

  root to: "home#index"

  get "dashboard", to: 'dashboard#show', as: :dashboard, constraints: Routes::LoggedInConstraint.new

  devise_for :users
end
