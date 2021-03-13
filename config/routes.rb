Rails.application.routes.draw do
  root to: "posts#index"
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :users ,only: [:show]
  resources :posts do
    resource :empathies, only: [:create, :destroy]
    resources :comments, only: [:new, :create, :destroy]
  end
end
