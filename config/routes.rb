Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  resources :users, only: [:new, :create]

  get '/dashboard', to: 'dashboard#index', as: 'dashboard'

  post '/', to: 'sessions#create'

  get '/discover', to: 'discover#index', as: 'discover'

  resources :movies, only: [:index, :show]
end
