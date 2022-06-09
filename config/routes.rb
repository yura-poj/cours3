# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'questions#index'

  resources :attachments, only: %i[destroy]
  resources :links, only: %i[destroy]

  resources :questions do
    resources :answers, shallow: true, only: %i[create destroy update edit new]
  end
end
