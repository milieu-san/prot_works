# frozen_string_literal: true

Rails.application.routes.draw do
  get 'homes/index'
  devise_for :users

  unauthenticated do
    root to: 'homes#index'
  end

  authenticated do
    root to: 'users#mypage'
  end

  get 'mypage', to: 'users#mypage'
  get 'mypage/edit', to: 'users#edit'
  patch 'mypage/update', to: 'users#update'

  resources :users, only: [:show]

  resources :prots do
    resources :nodes
    resources :reviews do
      resources :comments, only: %i[crete update destroy]
    end
  end

  get 'prot/search', to: 'prots#search'

  namespace :preview do
    resources :nodes, only: [:index]
  end

  resources :stars, only: %i[create destroy]
  resources :hearts, only: %i[create destroy]
  resources :goods, only: %i[create destroy]

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
