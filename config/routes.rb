Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }  
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/search', to: 'search#index', as: 'search'

  resources :users do
    get 'dashboard', on: :member
    resources :watchlists
  end
  resources :watchlists


  resources :items  do
    # resources :inquiries do
    #   resources :replies
    # end
  end

  resources :auctions, only: [:show] do
    resources :bids, only: [:create, :index]

    resources :inquiries do
      resources :replies
    end
  end

  resources :user_profiles, only: [:show, :edit, :update]
  get "up" => "rails/health#show", as: :rails_health_check


end
