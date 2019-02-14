Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  root to: 'prots#index'
  resource  :user
  resources :users, only: [:edit]
  resources :prots

  get '/prots/:id/node/', to: 'nodes#show'
  get '/prots/:id/node/edit', to: 'nodes#edit'

  if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
