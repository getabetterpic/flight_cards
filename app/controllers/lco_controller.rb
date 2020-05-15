class LcoController < ApplicationController
  before_action :authenticate_lco!, except: %i[launches new_lco signin_lco]
  before_action :load_flight_card, only: %i[edit update reset]

  def index
    @flight_cards = @launch.flight_cards.waiting_for_lco.order(pad_assignment: :asc)
    @flown = @launch.flight_cards.where(flown: true)
  end

  def edit; end

  def update
    @flight_card.update!(flown: true)
    redirect_to lco_cards_path
  end

  def reset
    @flight_card.update!(rso_approved: false, pad_assignment: nil)
    redirect_to lco_cards_path
  end

  def launches
    @launches = Launch.all
  end

  def new_lco
    @launch = Launch.find(params[:id])
  end

  def signin_lco
    @launch = Launch.find(params[:id])
    if @launch&.authenticate_lco(params[:lco_key])
      session[:launch_id] = @launch.id
      redirect_to lco_cards_path
    else
      render :new_lco, alert: 'Something went wrong.'
    end
  end

  private

  def lco_params
    params.require(:flight_card).permit(:flown, :rso_approved, :pad_assignment)
  end

  def load_flight_card
    @flight_card = FlightCard.find(params[:flight_card_id])
  end

  def authenticate_lco!
    @launch = Launch.find_by!(id: session[:launch_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to rso_launches_path
  end
end
