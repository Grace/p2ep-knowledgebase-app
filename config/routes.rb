Rails.application.routes.draw do
  resources :proteins
  resources :phenotypes
  resources :pathways
  resources :diseases
  resources :chemicals
  resources :genes
  resources :plants
  resources :nodes

  devise_for :users
  root to: "dashboard#index"
  get '/dashboard', to: 'dashboard#index'
  get '/home', to: 'dashboard#index'
  get '/env', to: 'dashboard#env'
  get '/search', to: 'dashboard#search'
end
