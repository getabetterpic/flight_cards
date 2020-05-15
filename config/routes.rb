Rails.application.routes.draw do
  devise_for :users
  root to: 'root#index'
  resources :flight_cards, only: %i[new create edit update index]
  resources :launches

  scope :rso do
    get 'launches', to: 'rso#launches', as: :rso_launches
    get 'launches/:id', to: 'rso#new_rso', as: :sign_in_rso
    post 'launches/:id', to: 'rso#signin_rso'

    get '', to: 'rso#index', as: :rso_cards
    get ':flight_card_id/edit', to: 'rso#edit', as: :edit_rso_card
    put ':flight_card_id', to: 'rso#update'
    patch ':flight_card_id', to: 'rso#update', as: :update_rso_card
  end
end
