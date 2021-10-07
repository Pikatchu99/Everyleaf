Rails.application.routes.draw do
  root to: 'users#new'
  resources :users
  resources :tasks
  resources :sessions, only: [:new, :create, :destroy]
  get "/search", to: "tasks#search", as: "search_tasks"
  namespace :admin do
    resources :users
  end
  # resources :labels
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
