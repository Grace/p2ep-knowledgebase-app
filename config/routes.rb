Rails.application.routes.draw do
  devise_for :users, controllers: {
      sessions: 'users/sessions'
  }

  resources :proteins
  resources :phenotypes
  resources :pathways
  resources :diseases
  resources :chemicals
  resources :genes
  resources :plants
  resources :nodes

  root to: "dashboard#index"
  get '/dashboard', to: 'dashboard#index'
  get '/home', to: 'dashboard#index'
  get '/env', to: 'dashboard#env'
  get '/search', to: 'dashboard#search'
end
