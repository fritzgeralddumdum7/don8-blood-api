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
    get 'test', to: 'tests#index'
    resources :blood_types
    resources :request_types
    resources :cases
    resources :donations
    resources :organizations do
      resources :blood_requests
    end
    resources :blood_requests
    resources :appointments
    resources :city_municipalities
    resources :provinces
  end
end
