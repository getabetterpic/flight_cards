class CreateFlightCards < ActiveRecord::Migration[6.0]
  def change
    create_table :flight_cards do |t|
      t.string :name, null: false
      t.json :memberships, default: {}
      t.string :rocket_name, default: ''
      t.string :rocket_manufacturer, default: ''
      t.string :rocket_type
      t.integer :stages, default: 1
      t.integer :cluster, default: 1
      t.string :launch_guide
      t.string :motor_manufacturer
      t.string :motor
      t.json :recovery, default: {}
      t.text :chute_release
      t.json :flight_info, default: {}
      t.boolean :rso_approved, default: false
      t.string :pad_assignment
      t.boolean :flown, default: false
      t.references :user

      t.timestamps
    end
  end
end
