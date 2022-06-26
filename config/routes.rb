# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'questions#index'

  resources :attachments, only: %i[destroy]
  resources :links, only: %i[destroy]
  resources :earned_rewards, only: %i[index]

  resources :questions do
    resources :answers, shallow: true, only: %i[create destroy update edit new] do
      get 'set_best', on: :member
    end
  end

  mount ActionCable.server => '/cable'
end
