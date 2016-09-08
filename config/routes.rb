Rails.application.routes.draw do
  resources :inventories
  resources :locations
  resources :items
  resources :item_types
  resources :transactions
  resources :transaction_types
  devise_for :users
  resources  :dashboard
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
end
