class FlightCardsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_flight_card, only: %i[edit update duplicate show]
  before_action :set_launch_session

  def new
    @flight_card = current_user.flight_cards.new
  end

  def create
    @flight_card = current_user.flight_cards.new(
      flight_card_params.merge(launch_id: params[:launch_id])
    )
    if @flight_card.save
      redirect_to launch_flight_cards_path(params[:launch_id])
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
      redirect_to edit_launch_flight_card_path(params[:launch_id], @new_flight_card)
    else
      redirect_to launch_flight_cards_path(params[:launch_id])
    end
  end

  def index
    @flight_cards = current_user.flight_cards.for_launch(params[:launch_id]).not_flown
    @flown = current_user.flight_cards.for_launch(params[:launch_id]).flown
  end

  def update
    if @flight_card.update(flight_card_params)
      redirect_to launch_flight_cards_path(params[:launch_id])
    else
      render :edit, alert: 'Something went wrong.'
    end
  end

  private

  def set_launch_session
    session[:launch_id] = params[:launch_id]
  end

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
