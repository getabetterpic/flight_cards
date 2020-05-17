class ChangePadAssignmentToInteger < ActiveRecord::Migration[6.0]
  def change
    remove_column :flight_cards, :pad_assignment
    add_column :flight_cards, :pad_assignment, :integer
  end
end
