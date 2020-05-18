class RsoController < ApplicationController
  before_action :authenticate_rso!, except: %i[launches new_rso signin_rso]
  before_action :load_flight_card, only: %i[edit update]

  def index
    @flight_cards = @launch.flight_cards.for_launch(params[:launch_id])
                           .waiting_for_rso
    @approved = @launch.flight_cards.for_launch(params[:launch_id]).not_flown
                       .where(rso_approved: true)
                       .order(pad_assignment: :asc)
  end

  def update
    if @flight_card.update(rso_params)
      redirect_to launch_rso_cards_path(params[:launch_id])
    else
      render :edit, alert: 'Please try again.'
    end
  end

  def launches
    @launches = Launch.all
  end

  def new_rso
    @launch = Launch.find(params[:launch_id])
  end

  def signin_rso
    @launch = Launch.find(params[:launch_id])
    if @launch&.authenticate_rso(params[:rso_key])
      session[:launch_id] = @launch.id
      redirect_to launch_rso_cards_path(@launch)
    else
      render :new_rso, alert: 'Something went wrong.'
    end
  end

  private

  def load_flight_card
    @flight_card = @launch.flight_cards.find(params[:flight_card_id])
  end

  def rso_params
    params.require(:flight_card).permit(:rso_approved, :pad_assignment)
  end

  def authenticate_rso!
    @launch ||= Launch.find_by!(id: session[:launch_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to rso_launches_path
  end
end
