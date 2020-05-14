class AddKeysToLaunch < ActiveRecord::Migration[6.0]
  def change
    add_column :launches, :rso_digest, :string
    add_column :launches, :lco_digest, :string
  end
end
