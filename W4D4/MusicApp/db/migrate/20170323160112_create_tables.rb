class CreateTables < ActiveRecord::Migration
  def change
    create_table :bands do |t|
      t.string :name, null:false
    end

    create_table :albums do |t|
      t.string :name, null:false
      t.integer :band_id, null:false
      t.string :status, null:false
    end

    create_table :tracks do |t|
      t.string :name, null:false
      t.integer :album_id, null:false
      t.text :description
      t.string :status, null:false
    end
  end
end
