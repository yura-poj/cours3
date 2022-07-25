# frozen_string_literal: true
require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  use_doorkeeper
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  root 'questions#index'

  resources :attachments, only: %i[destroy]
  resources :links, only: %i[destroy]
  resources :earned_rewards, only: %i[index]

  resources :questions do
    resources :answers, shallow: true, only: %i[create destroy update edit new] do
      get 'set_best', on: :member
    end
  end

  namespace :api do
    namespace :v1 do
      resources :profiles, only: [] do
        get :me, on: :collection
      end
      resources :questions, only: %i[create update destroy index show] do
        resources :answers, shallow: true, only: %i[create update destroy show]
      end
    end
  end

  mount ActionCable.server => '/cable'
end
