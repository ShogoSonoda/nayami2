Rails.application.routes.draw do

  root to: "posts#index"
  
  devise_for :users, controllers: { registrations: 'users/registrations' }
  
  resources :users ,only: [:show] do
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
  end

  resources :posts do
    resource :empathies, only: [:create, :destroy]
    resources :comments, only: [:new, :create, :destroy]
    get :search, on: :collection
  end

  resources :messages, only: [:create]

  resources :rooms, only: [:create, :show]

  resources :notifications, only: :index
end
