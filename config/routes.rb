Rails.application.routes.draw do
  get 'sessions/new'
  get 'users/new'
  get 'players/new'
  root 'static_pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # root 'welcome#index'
  get '/get_tournament_info', to: 'static_pages#get_tournament_info'
  resources :tournament_years, only: [:show]
  resources :tournaments, only: [:show]
  resources :players, only: [:show]
  get '/player_matches_index', to: 'player_matches#index'
  resources :users, only: [:new, :create, :edit, :update]
  resources :favorites, only: [:create, :destroy]
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
