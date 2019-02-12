Rails.application.routes.draw do
  root to: 'prots#index'
  resources :prots, except: [:index]
end
