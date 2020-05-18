Rails.application.routes.draw do
  devise_for :users
  root to: 'root#index'

  resources :launches do
    resources :flight_cards do
      post 'duplicate', on: :member, to: 'flight_cards#duplicate', as: :duplicate
    end

    scope :rso do
      get '', on: :collection, to: 'rso#launches', as: :rso
      get 'new', to: 'rso#new_rso'
      post '', to: 'rso#signin_rso', as: :sign_in_rso

      get '', to: 'rso#index', as: :rso_cards
      get 'flight_cards/:flight_card_id/edit', to: 'rso#edit', as: :edit_rso_card
      put 'flight_cards/:flight_card_id', to: 'rso#update'
      patch 'flight_cards/:flight_card_id', to: 'rso#update', as: :update_rso_card
    end

    scope :lco do
      get '', on: :collection, to: 'lco#launches', as: :lco
      get 'new', to: 'lco#new_lco', as: :sign_in_lco
      post 'new', to: 'lco#signin_lco'

      get '', to: 'lco#index', as: :lco_cards
      get 'flight_cards/:flight_card_id/edit', to: 'lco#edit', as: :edit_lco_card
      put 'flight_cards/:flight_card_id', to: 'lco#update'
      patch 'flight_cards/:flight_card_id', to: 'lco#update', as: :update_lco_card
      delete 'flight_cards/:flight_card_id', to: 'lco#reset', as: :reset_lco_card
    end
  end
end
