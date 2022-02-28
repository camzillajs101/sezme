Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  devise_for :admins # controllers exist but are not used yet

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'posts#index', as: :posts
  resources :posts, except: [:index, :destroy] do # yes, although this is three levels of nesting, because they're shallow, the paths never get more than two levels deep
    resources :reviews, shallow: true, except: :index do
      resources :replies, shallow: true, except: :show
    end
  end
  resources :votes, only: [:create, :destroy]
  get '/users/:username', to: 'users#show', as: :user
  get '/users/', to: 'users#index', as: :users

  get '/pages/:page', to: 'pages#show'
end
