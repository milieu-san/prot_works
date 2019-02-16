Rails.application.routes.draw do
  get 'homes/index'
  devise_for :users

  unauthenticated do
     root to: 'homes#index'
  end

  authenticated do
    root to: 'users#show'
  end

  resource  :user
  resources :users, only: [:edit]

  resources :prots do
    resources :nodes
    resources :reviews
  end

  namespace :preview do
    resources :nodes, only: [:index]
  end


  if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
