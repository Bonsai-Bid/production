Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }  
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/search', to: 'search#index', as: 'search'

  resources :users do
    get 'dashboard', on: :member
    # get 'profile', on: :member
    resources :watchlists
    # resources :sale_transactions, only: [:index]  
  end
  resources :watchlists


  resources :items do
    # resources :inquiries do
    #   resources :replies
    # end
  end

  resources :auctions, only: [:show] do
    get 'bidding_history', on: :member
    resources :bids, only: [:create]
    resources :inquiries do
      resources :replies
    end
  end
  
  get "up" => "rails/health#show", as: :rails_health_check


end
