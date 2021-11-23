Rails.application.routes.draw do
  get 'errors/not_found'
  get 'errors/internal_server_error'
  get 'sessions/new'
  get 'users/new'
  get 'players/new'
  root 'static_pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # root 'welcome#index'
  get '/get_tournament_info', to: 'static_pages#get_tournament_info'
  get '/get_tournament_list', to: 'static_pages#get_tournament_list'
  resources :tournament_years, only: [:show]
  # get '/tournament_years/:id', to: 'tournament_years#show'
  get '/tournament_years_day_show/:id', to: 'tournament_years#day_show', as: 'tournament_year_day_show'
  resources :tournaments, only: [:show]
  resources :players, only: [:show]
  get '/player_matches_index', to: 'player_matches#index'
  resources :users, only: [:new, :create, :edit, :update]
  resources :favorites, only: [:create, :destroy]
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/search', to: 'searches#search'
  match "/404", to: 'errors#not_found', via: :all
  match "/500", to: 'errors#internal_server_error', via: :all
end
