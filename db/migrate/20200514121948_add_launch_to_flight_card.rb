class AddLaunchToFlightCard < ActiveRecord::Migration[6.0]
  def change
    add_reference :flight_cards, :launch
  end
end
