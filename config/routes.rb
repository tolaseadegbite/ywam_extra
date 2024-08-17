Rails.application.routes.draw do
  devise_for :accounts, controllers: {
    sessions: 'accounts/sessions',
    registrations: 'accounts/registrations'
  }
  
  root 'pages#home'
  get "up" => "rails/health#show", as: :rails_health_check
end
