Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get                   'sessions/new'
  get                   'users/new'
  root                  'static_pages#home'
  get   '/home',    to: 'static_pages#home'
  get   '/help',    to: 'static_pages#help'
  get   '/about',   to: 'static_pages#about'
  get   '/signup',  to: 'users#new'
  get   '/login',   to: 'sessions#new'
  post  '/login',   to: 'sessions#create'
  get '/logout',  to: 'sessions#destroy'
  get '/bet', to: 'games#bet'
  get   '/games/:id/hit',    to: 'games#hit', as: 'hit'
  get   '/games/:id/stand',    to: 'games#stand', as: 'stand'
  resources :contact, only: [:index, :new, :create]
  resources :users
  resources :game_sessions
  resources :games 

end
