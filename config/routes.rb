Rails.application.routes.draw do
  devise_for :users
  root to: 'root#index'
  resources :flight_cards, only: %i[new create edit update index]
end
