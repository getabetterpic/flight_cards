Rails.application.routes.draw do
  devise_for :users
  root to: 'root#index'
  resources :flight_cards do
    post 'duplicate', on: :member, to: 'flight_cards#duplicate', as: :duplicate
  end
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

  scope :lco do
    get 'launches', to: 'lco#launches', as: :lco_launches
    get 'launches/:id', to: 'lco#new_lco', as: :sign_in_lco
    post 'launches/:id', to: 'lco#signin_lco'

    get '', to: 'lco#index', as: :lco_cards
    get ':flight_card_id/edit', to: 'lco#edit', as: :edit_lco_card
    put ':flight_card_id', to: 'lco#update'
    patch ':flight_card_id', to: 'lco#update', as: :update_lco_card
    delete ':flight_card_id', to: 'lco#reset', as: :reset_lco_card
  end
end
