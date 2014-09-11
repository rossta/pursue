Rails.application.routes.draw do

  concern :calendar do
    get 'week/:week', to: 'workout_plans#index', as: :week
    get 'week/:week/day/:day', to: 'workout_plans#index', as: :week_day
  end

  resources :schedules, concerns: :calendar

  resources :training_plans, concerns: :calendar, path: 'training-plans' do
    resources :workout_plans, path: 'workouts'
  end

  resources :events

  resources :tags

  root to: "home#index"

  get "dashboard", to: 'dashboard#show', as: :dashboard, constraints: Routes::LoggedInConstraint.new

  devise_for :users
end
