Rails.application.routes.draw do
  root to: "posts#index"
  get 'posts/index'
  devise_for :users
end
