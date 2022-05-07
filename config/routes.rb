Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    get 'test', to: 'tests#index'
    resources :blood_types
    resources :organizations do
      resources :blood_requests
    end
    resources :blood_requests
  end
end
