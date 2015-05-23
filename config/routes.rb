Rails.application.routes.draw do
	# root routes
	authenticated :user do
		root to: "welcome#how_it_works", as: :authenticated_root
	end
	root to: "countries#index"

	# standalone routes
	get "how-it-works", to: "welcome#how_it_works"

	# model routes
	get "countries", to: "countries#index"

	devise_for :users
	resources :users

	resources :country_travel_records


end
