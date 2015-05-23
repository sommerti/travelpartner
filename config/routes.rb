Rails.application.routes.draw do
  get 'welcome/index'

  get 'welcome/how_it_works'

  devise_for :users
  root to: 'countries#index'


end
