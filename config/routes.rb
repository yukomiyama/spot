Rails.application.routes.draw do
  get 'user_communities/create'
  get 'communities/index'
  get 'favorites/create'
  get 'favorites/destroy'
  root 'pages#index'
  get     '/login',   to: 'sessions#new'
  post    '/login',   to: 'sessions#create'
  delete  '/logout',  to: 'sessions#destroy'

  resources :users do
    member do
      get :following, :followers
    end
    resources :tags, only: [:show] do
    end
  end
  resources :articles, only: [:new, :create, :edit, :update, :destroy, :show, :index] do
    resources :comments, only: [:new, :create] do
    end
  end
  resources :favorites, only: [:create, :destroy, :index]
  resources :relationships, only: [:create, :destroy]
  resources :communities
  resources :user_communities, only: [:create, :destroy]
end
