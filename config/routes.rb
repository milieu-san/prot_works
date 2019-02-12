Rails.application.routes.draw do
  devise_for :users
  root to: 'prots#index'
  resources :prots

  if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
