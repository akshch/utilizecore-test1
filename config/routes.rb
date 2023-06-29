Rails.application.routes.draw do

  devise_for :users
  scope "/admin" do
    resources :users
  end

  resources :service_types
  resources :parcels
  resources :addresses
  root to: 'parcels#index'
  get '/search', to: 'search#index'
  resources :reports, only: :index
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
