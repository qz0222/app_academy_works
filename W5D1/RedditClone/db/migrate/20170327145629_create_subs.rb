class CreateSubs < ActiveRecord::Migration[5.0]
  def change
    create_table :subs do |t|
      t.string :title, null:false
      t.text :description, null:false
      t.integer :user_id, null:false

      t.timestamps
    end

    add_index :subs, :user_id
  end
end
