Rails.application.routes.draw do
  root to: 'users#new'
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  resources :tasks
  get "/search", to: "tasks#search", as: "search_tasks"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
