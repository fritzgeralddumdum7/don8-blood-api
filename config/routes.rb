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
    resources :users 
    patch 'blood_requests/:id/close', to: 'blood_requests#close', as: 'close_blood_request'
    patch 'blood_requests/:id/reOpen', to: 'blood_requests#reOpen', as: 'reOpen_blood_request'
    patch 'blood_requests/:id/cancel', to: 'blood_requests#cancel', as: 'cancel_blood_request'
    patch 'appointments/:id/complete', to: 'appointments#complete', as: 'complete_appointment'
    patch 'appointments/:id/cancel', to: 'appointments#cancel', as: 'cancel_appointment'
  end
end
