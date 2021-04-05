Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get                   'sessions/new'
  get                   'users/new'
  root                  'static_pages#home'
  get   '/home',    to: 'static_pages#home'
  get   '/help',    to: 'static_pages#help'
  get   '/about',   to: 'static_pages#about'
  get   '/contact', to: 'static_pages#contact'
  get   '/signup',  to: 'users#new'
  get   '/login',   to: 'sessions#new'
  post  '/login',   to: 'sessions#create'
  delete'/logout',  to: 'sessions#destroy'
  get   '/games/:id/hit',    to: 'games#hit'
  get   '/games/:id/stand',    to: 'games#stand'
  resources :users
  resources :game_sessions
  resources :games 

end
