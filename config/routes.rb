Rails.application.routes.draw do
  root 'static_pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # root 'welcome#index'
  get 'static_pages/get_tournament_info'
end
