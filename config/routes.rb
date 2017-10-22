Rails.application.routes.draw do
  get 'invites/create'

  get 'invites/destroy'

	root 'static_pages#home'
	get '/signup', 		to: 'users#new'
	post '/signup',		to: 'users#create'
	get '/login', 		to: 'sessions#new'
	post '/login', 		to: 'sessions#create'
	delete '/logout', to: 'sessions#destroy'
	resources :users, only: [:new, :create, :show, :edit, :update]
	resources :events, only: [:new, :create, :show, :index]
	resources :invites, only: [:create, :destroy]
end