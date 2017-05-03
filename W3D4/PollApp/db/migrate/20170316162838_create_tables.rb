class CreateTables < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.string :title, null: false
      t.integer :author_id, null: false

      t.timestamps
    end

    add_index :polls, :title

    create_table :questions do |t|
      t.integer :poll_id, null: false
      t.text :question_text, null: false

      t.timestamps
    end

    add_index :questions, :question_text

    create_table :answer_choices do |t|
      t.integer :question_id, null: false
      t.text :answer_text, null: false

      t.timestamps
    end

    add_index :answer_choices, :answer_text

    create_table :responses do |t|
      t.integer :answer_choice_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end




  end


end
