class CreateTaggings < ActiveRecord::Migration[5.0]
  def change
    create_table :taggings do |t|
      t.integer :shortened_url_id
      t.integer :tag_topic_id
    end
  end
end
