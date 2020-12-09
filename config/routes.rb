Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'posts#index', as: :posts
  resources :posts, only: [:show, :new, :create, :destroy]
  resources :users, only: :show
end
