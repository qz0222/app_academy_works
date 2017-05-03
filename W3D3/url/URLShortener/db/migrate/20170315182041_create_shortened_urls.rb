class CreateShortenedUrls < ActiveRecord::Migration[5.0]
  def change
    create_table :shortened_urls do |t|
      t.string :long_url
      t.string :short_url

    end
  end
end
