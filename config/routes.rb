Rails.application.routes.draw do
  
  namespace :admin do

    resource :system, only: [:show]
    
    resource :statistic, only: [:show]
      
    resource :account, only: [] do 
      put :invite_create_account
      put :cancel_invite_create_account
    end

    resources :users, only: [:index, :show]
    resources :accounts, only: [:index, :show]
  end

  namespace :apiv1 do
    get 'auth/gettoken'
    get 'auth/renewtoken'
    get 'auth/verifytoken'
    resources :locations
    resources :items
  end

  resource :user_profiles, only: [:edit, :show, :update] do
    member do
      put :member_invitation
      put :new_account_invitation
      put :change_current_account
    end  
  end  

  resources :accounts do
    member do 
      put :invite_member
      put :cancel_invitation
      put :change_admin_status
      delete :admin_destroy
      put  :export_data
      put  :import_data
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
  resources :locations do
    get :location_tree, :on => :collection
    member do
      get :show_inventory
    end
  end
  
  resources :items 
  resources :item_types
  resources :transactions
  resources :transaction_types
  resources :item_searches
  #devise_for :users
  resources  :dashboard
  resources :account_setup
  get 'search',  to: 'dashboard#search', as: :search 
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
end
