Rails.application.routes.draw do

  root to: "posts#index"

  get 'tags/index'
  
  devise_for :users, controllers: { registrations: 'users/registrations' }
  
  resources :users ,only: [:show] do
    member do
      get :followings, :followers
    end
    get :search, on: :collection
  end

  resources :posts do
    get :search_result, on: :collection
    get :sort_empathy, on: :collection
    get :tag_posts, on: :collection
  end
  
  resources :comments, only: [:new, :create, :destroy]
  
  resources :rooms, only: [:create, :show, :index]

  resources :notifications, only: :index

  namespace :api, format: :json do
    namespace :v1 do
      resources :empathies, only: [:create, :destroy]
      resources :relationships, only: [:create, :destroy]
      resources :messages, only: [:create]
    end
  end
end
