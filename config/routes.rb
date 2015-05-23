Rails.application.routes.draw do
	authenticated :user do
	root to: "welcome#how_it_works", as: :authenticated_root
	end
	#root to: "welcome#index"
	root to: "countries#index"

	get "how-it-works", to: "welcome#how_it_works"
	get "countries", to: "countries#index"

	devise_for :users
	resources :users



end
