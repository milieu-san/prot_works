Rails.application.routes.draw do
  devise_for :users
  root to: 'prots#index'
  resource  :user
  resources :users, only: [:edit]
  # resources :prots

  resources :prots
  #  do
  #   resources :nodes
  # end
  resources :nodes

  # get '/prots/:id/node', to: 'nodes#show'
  # get '/prots/:id/node/edit', to: 'nodes#index'

  if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
