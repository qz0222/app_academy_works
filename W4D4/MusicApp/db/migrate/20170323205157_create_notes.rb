class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.integer :user_id, null:false
      t.integer :track_id, null:false
      t.text :body

      t.timestamps
    end
  end
end
