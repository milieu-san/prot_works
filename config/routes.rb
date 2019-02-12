Rails.application.routes.draw do
  root to: 'prot#index'
  resources :prots, exceps: [:index]
end
