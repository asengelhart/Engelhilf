Rails.application.routes.draw do
  root to: 'welcome#home'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
  get '/auth/google_oauth2/callback', to: 'sessions#create_by_oauth'

  resources :comments, only: [:new, :create, :edit, :update, :destroy]
  resources :tickets do
    resources :comments, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  end
  resources :users, only: [:show] do
    resources :tickets, only: [:index]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
