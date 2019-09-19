Rails.application.routes.draw do
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
    resources :articles, only: [:new, :create, :edit, :update, :destroy, :show] do
      resources :comments, only: [:new, :create] do
      end
    end
    resources :tags, only: [:show] do
    end
  end
  resources :favorites, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
end
