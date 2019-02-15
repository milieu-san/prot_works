Rails.application.routes.draw do
  devise_for :users
  root to: 'prots#index'
  resource  :user
  resources :users, only: [:edit]

  resources :prots do
    resources :nodes
  end

  namespace :preview do
    resources :nodes, only: [:index]
  end

  if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
