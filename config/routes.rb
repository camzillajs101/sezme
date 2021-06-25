Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  devise_for :admins # controllers exist but are not used yet

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'posts#index', as: :posts
  resources :posts, except: [:index, :destroy] do
    resources :reviews, except: :index
  end
  get '/users/:username', to: 'users#show', as: :user
  get '/users/', to: 'users#index', as: :users

  get '/pages/:page', to: 'pages#show'
end
