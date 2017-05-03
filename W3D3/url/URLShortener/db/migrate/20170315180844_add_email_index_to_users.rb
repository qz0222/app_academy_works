class AddEmailIndexToUsers < ActiveRecord::Migration[5.0]
  def change
    add_index :users, :emial
  end
end
