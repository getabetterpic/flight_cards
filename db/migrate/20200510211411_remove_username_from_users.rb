class RemoveUsernameFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_index :users, :username
    remove_column :users, :username
  end
end
