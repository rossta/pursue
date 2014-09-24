Rails.application.routes.draw do

  root to: "home#index"

  get "dashboard", to: 'dashboard#show', as: :user_root, constraints: Routes::LoggedInConstraint.new

  concern :calendar do
    get 'week/:week', to: 'entries#index', as: :week
    get 'week/:week/day/:day', to: 'entries#index', as: :week_day
  end

  resources :schedules, concerns: :calendar

  resources :training_plans, concerns: :calendar, path: 'training-plans' do
    resources :entries, path: 'workouts'
  end

  resources :events

  resources :tags

  get 'accounts/start', to: redirect('start')

  devise_for :users, skip: [:sessions], path: 'accounts', path_names: { sign_up: 'start' }
  as :user do
    get 'resume' => 'devise/sessions#new', :as => :new_user_session
    post 'resume' => 'devise/sessions#create', :as => :user_session
    match 'pause' => 'devise/sessions#destroy', :as => :destroy_user_session,
      :via => Devise.mappings[:user].sign_out_via

    get 'start' => 'devise/registrations#new', :as => :sign_up
  end
end
