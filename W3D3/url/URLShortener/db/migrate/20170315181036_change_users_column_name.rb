class ChangeUsersColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :emial, :email
  end
end
