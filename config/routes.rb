Rails.application.routes.draw do
	# root routes
	authenticated :user do
		root to: "welcome#how_it_works", as: :authenticated_root
	end
	root to: "countries#index"

	# standalone routes
	get "how-it-works", to: "welcome#how_it_works"
	get "wiki", to: "welcome#wiki"

	# model routes
	get "countries", to: "countries#index"

	devise_for :users
	resources :users do
		member do
			get "travel_profile"
			post "create_update_country_travel_record", to: "country_travel_records#create_update"
		end
	end

	resources :country_travel_records


end
