Rails.application.routes.draw do
  root to: 'welcome#home'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
  get '/auth/google_oauth2/callback', to: 'sessions#create_by_oauth'

  resources :comments
  resources :tickets
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
