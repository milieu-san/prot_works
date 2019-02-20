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
      resources :comments
    end
  end

  namespace :preview do
    resources :nodes, only: [:index]
  end

  resources :stars, only: [:create, :destroy]

  if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
