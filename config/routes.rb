Rails.application.routes.draw do
  devise_for :users,
  defaults: { format: :json },
  path: 'api',
  path_names: {
    sign_in: '/login',
    sign_out: '/logout',
    registration: '/signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    get '/profile', to: 'users#profile'
    post '/validate-password', to: 'users#validate_password'
    put '/update-password', to: 'users#update_password'
    resources :blood_types
    resources :request_types
    resources :organization_types
    resources :cases
    resources :donations
    resources :organizations
    resources :blood_requests
    resources :appointments
    resources :city_municipalities
    resources :provinces    
  end
end
