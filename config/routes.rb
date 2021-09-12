Rails.application.routes.draw do
  get 'users/new'
  get 'players/new'
  root 'static_pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # root 'welcome#index'
  get '/get_tournament_info', to: 'static_pages#get_tournament_info'
  resources :tournament_years, only: [:show]
  resources :players, only: [:show]
  resources :users, only: [:new, :create]
end
