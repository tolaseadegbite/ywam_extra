Rails.application.routes.draw do 
  root 'podcasts#index'

  devise_for :accounts, controllers: {
    sessions: 'accounts/sessions',
    registrations: 'accounts/registrations'
  }

  resources :relationships, only: [:create, :destroy]
  resources :podcasts do
    resources :episodes, except: [:index]
  end
  resources :tags, only: [:create, :show]
  resources :follows, only: [:create, :destroy]

  resources :podcasts do
    resources :reviews
  end

  get "up" => "rails/health#show", as: :rails_health_check

  scope(path: ':username', constraints: { username: /[^\/]+/ }) do
    get '/', to: 'profiles#show', as: :profile
    get '/following', to: 'profiles#following', as: :profile_following
    get '/followers', to: 'profiles#followers', as: :profile_followers
    get '/edit', to: 'profiles#edit', as: :edit_profile
    patch '/edit', to: 'profiles#update', as: :update_profile
    delete '/cover_image', to: 'profiles#destroy_cover_image', as: :destroy_profile_cover_image
  end
end
