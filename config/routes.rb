Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :tasks
  get "/search", to: "tasks#search", as: "search_tasks"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
