Rails.application.routes.draw do

  root 'podcasts#index'  

  devise_for :accounts, controllers: {
    sessions: 'accounts/sessions',
    registrations: 'accounts/registrations'
  }

  resources :relationships, only: [:create, :destroy]

  resources :podcasts do
    resources :reviews
    resources :episodes do
      resources :comments, only: [:create]
      resources :plays, only: [:create, :destroy]
      member do
        post 'save_progress'
      end
    end
    resources :comments, only: [:create, :destroy]
  end

  resources :events, only: [:index, :show] do
    member do
      post 'rsvp'
      delete 'cancel_rsvp'
    end
    collection do
      get 'going'
      get 'interested'
      get 'past_events'
    end
  end

  namespace :dashboard do
    resources :podcasts do
      resources :episodes
    end
    resources :events
    # get '/', to: '/dashboard/dashboard#index'
  end

  resources :comments do
    resources :comments, only: [:create]
  end

  resources :comments, only: [:edit, :update, :destroy]

  resources :tags, only: [:create, :show]
  resources :follows, only: [:create, :destroy]
  
  resources :playlists 

  get "up" => "rails/health#show", as: :rails_health_check

  scope(path: ':username', constraints: { username: /[^\/]+/ }) do
    get '/', to: 'profiles#show', as: :profile
    get '/events', to: 'profiles#events', as: :profile_events
    get '/following', to: 'profiles#following', as: :profile_following
    get '/followers', to: 'profiles#followers', as: :profile_followers
    get '/edit', to: 'profiles#edit', as: :edit_profile
    patch '/edit', to: 'profiles#update', as: :update_profile
    delete '/cover_image', to: 'profiles#destroy_cover_image', as: :destroy_profile_cover_image
  end
end
