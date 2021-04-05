Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'posts#index', as: :posts
  resources :posts, except: [:index, :destroy] do
    resources :reviews, only: [:create, :destroy]
  end
  get '/users/:username', to: 'users#show', as: :user
  get '/pages/:page', to: 'pages#show'
end
