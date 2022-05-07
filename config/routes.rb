Rails.application.routes.draw do
  get 'provinces/index'
  get 'provinces/show'
  get 'city_municipalities/index'
  get 'city_municipalities/show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    get 'test', to: 'tests#index'
    resources :blood_types
    resources :organizations do
      resources :blood_requests
    end
    resources :blood_requests
    resources :city_municipalities
    resources :provinces
  end
end
