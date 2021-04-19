Rails.application.routes.draw do

  root to: "posts#index"
  
  devise_for :users, controllers: { registrations: 'users/registrations' }
  
  resources :users ,only: [:show] do
    member do
      get :followings, :followers
    end
    resources :relationships, only: [:create, :destroy]
    get :search, on: :collection
  end

  resources :posts do
    resources :comments, only: [:new, :create, :destroy]
    get :search, on: :collection
    get :sort_empathy, on: :collection
    get :tag_index, on: :collection
    get :tag_posts, on: :collection
  end

  resources :messages, only: [:create]

  resources :rooms, only: [:create, :show, :index]

  resources :notifications, only: :index

  namespace :api, format: :json do
    namespace :v1 do
      resources :empathies, only: [:create, :destroy]
    end
  end
end
