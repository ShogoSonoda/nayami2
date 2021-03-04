Rails.application.routes.draw do
  get 'users/show'
  root to: "posts#index"
  get 'posts/index'
  devise_for :users, controllers: { registrations: 'users/registrations' }
end
