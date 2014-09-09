Rails.application.routes.draw do

  resources :schedules

  resources :events

  resources :tags

  resources :training_plans, path: 'training-plans' do
    resources :workout_plans, path: 'workouts'

    get 'week/:week', to: 'workout_plans#index', as: :week
    get 'week/:week/day/:day', to: 'workout_plans#index', as: :week_day
  end

  root to: "home#index"

  get "dashboard", to: 'dashboard#show', as: :dashboard, constraints: Routes::LoggedInConstraint.new

  devise_for :users
end
