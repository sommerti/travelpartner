Rails.application.routes.draw do
	# root routes
	authenticated :user do
		root to: 'users#travel_records', as: :authenticated_root
	end
	root to: "welcome#index"

	# standalone routes
	get "how-it-works", to: "welcome#how_it_works"
	get "wiki", to: "welcome#wiki"

	# model routes
	get "countries", to: "countries#index"
	get "update_country", to: "countries#update"

	devise_for :users
	resources :users do
		member do
			get "travel_records"
			get "big_map"
			get "match"
			post "create_update_country_travel_record", to: "country_travel_records#create_update"
			get "follow"
	    	get "unfollow"
	    	get "my_connections"
		end
	end

	resources :country_travel_records
end