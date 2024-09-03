Rails.application.routes.draw do
  devise_for :accounts, controllers: {
    sessions: 'accounts/sessions',
    registrations: 'accounts/registrations'
  }

  resources :relationships,       only: [:create, :destroy]
  
  root 'pages#home'
  get "up" => "rails/health#show", as: :rails_health_check

  scope(path: ':username', constraints: { username: /[^\/]+/ }) do
    get '/', to: 'profiles#show', as: :profile
    get '/following', to: 'profiles#following', as: :profile_following
    get '/followers', to: 'profiles#followers', as: :profile_followers
    get '/edit', to: 'profiles#edit', as: :edit_profile
    patch '/edit', to: 'profiles#update', as: :update_profile
  end
end
