class CreateLaunches < ActiveRecord::Migration[6.0]
  def change
    create_table :launches do |t|
      t.datetime :date
      t.string :location
      t.string :name, null: false
      t.references :admin, null: false, foreign_key: true

      t.timestamps
    end
  end
end
