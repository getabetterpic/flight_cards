class LcoController < ApplicationController
  before_action :authenticate_lco!, except: %i[launches new_lco signin_lco]
  before_action :load_flight_card, only: %i[edit update reset]

  def index
    @flight_cards = @launch.flight_cards.waiting_for_lco.order(pad_assignment: :asc)
  end

  def update
    @flight_card.update!(flown: params[:flight_card][:flown])
    redirect_to launch_lco_cards_path(@launch)
  end

  def reset
    @flight_card.update!(rso_approved: false, pad_assignment: nil, flown: false)
    redirect_to launch_lco_cards_path(@launch)
  end

  def launches
    @launches = Launch.all
  end

  def flown
    @flown = @launch.flight_cards.where(flown: true)
  end

  def new_lco
    @launch = Launch.find(params[:launch_id])
  end

  def signin_lco
    @launch = Launch.find(params[:launch_id])
    if @launch&.authenticate_lco(params[:lco_key])
      session[:launch_id] = @launch.id
      session[:lco_login] = true
      redirect_to launch_lco_cards_path(@launch)
    else
      render :new_lco, alert: 'Something went wrong.'
    end
  end

  private

  def lco_params
    params.require(:flight_card).permit(:flown, :rso_approved, :pad_assignment)
  end

  def load_flight_card
    @flight_card = @launch.flight_cards.find(params[:flight_card_id])
  end

  def authenticate_lco!
    @launch = Launch.find_by!(id: session[:launch_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to lco_launches_path
  end
end
