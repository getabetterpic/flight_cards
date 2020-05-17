class FlightCardsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_flight_card, only: %i[edit update duplicate show]

  def new
    session[:launch_id] = params[:launch] if params[:launch]
    @flight_card = current_user.flight_cards.new
  end

  def create
    @flight_card = current_user.flight_cards.new(flight_card_params.merge(launch_id: session[:launch_id]))
    if @flight_card.save
      redirect_to flight_cards_path
    else
      render :new, alert: 'Something went wrong.'
    end
  end

  def duplicate
    @new_flight_card = current_user.flight_cards.new(
      @flight_card.attributes.with_indifferent_access.slice(
        :name, :rocket_manufacturer, :rocket_name, :rocket_type,
        :stages, :cluster, :launch_guide, :motor_manufacturer, :motor,
        :chute_release, :recovery, :launch_id
      )
    )
    if @new_flight_card.save!
      redirect_to edit_flight_card_path(@new_flight_card)
    else
      redirect_to flight_cards_path
    end
  end

  def index
    @flight_cards = current_user.flight_cards.for_launch(session[:launch_id]).not_flown
    @flown = current_user.flight_cards.for_launch(session[:launch_id]).flown
  end

  def edit; end

  def update
    if @flight_card.update(flight_card_params)
      redirect_to flight_cards_path
    else
      render :edit, alert: 'Something went wrong.'
    end
  end

  private

  def load_flight_card
    @flight_card = current_user.flight_cards.find(params[:id])
  end

  def flight_card_params
    params.require(:flight_card).permit(
      :name, :rocket_name, :rocket_manufacturer, :rocket_type,
      :stages, :cluster, :launch_guide, :motor_manufacturer, :motor,
      :chute_release,
      flight_info: %i[first_flight heads_up first_time_flier nothing],
      recovery: %i[parachute streamer glider tumble helicopter other],
      memberships: %i[tra nar soar nothing]
    )
  end
end
