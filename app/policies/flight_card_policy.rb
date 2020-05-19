class FlightCardPolicy < ApplicationPolicy
  attr_reader :user, :flight_card

  def initialize(user, flight_card)
    @user = user
    @flight_card = flight_card
  end

  def destroy?
    user && user.id == flight_card.user_id && !flight_card.flown?
  end
end
