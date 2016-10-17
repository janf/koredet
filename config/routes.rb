Rails.application.routes.draw do
  
  resource :user_profiles, only: [:edit, :show, :update] do
    member do
      put :accept_invitation
    end  
  end  

  resources :accounts do
    member do 
      put :invite_member
    end
  end    

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resource :accounts, only: [:new, :create, :edit, :show]

  resources :cart_items
  resources :carts do
    member do
      put :process_cart
    end
    get :autocomplete_item_name, :on => :collection
  end 
  resources :inventories
  resources :locations
  resources :items 
  resources :item_types
  resources :transactions
  resources :transaction_types
  resources :item_searches
  #devise_for :users
  resources  :dashboard
  get 'search',  to: 'dashboard#search', as: :search 
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
end
