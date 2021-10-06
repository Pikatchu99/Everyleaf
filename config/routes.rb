Rails.application.routes.draw do
  root to: 'users#new'
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :tasks
  get "/search", to: "tasks#search", as: "search_tasks"
  namespace :admin do
    resources :users
  end
  get '/404', to: 'errors#not_found'
  get '/422', to: 'errors#unprocessable'
  get '/500', to: 'errors#internal_server'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
