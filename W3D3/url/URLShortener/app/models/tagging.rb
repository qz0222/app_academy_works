# == Schema Information
#
# Table name: taggings
#
#  id               :integer          not null, primary key
#  shortened_url_id :integer
#  tag_topic_id     :integer
#

class Tagging < ActiveRecord::Base
  validates :shortened_url_id, :presence => true
  validates :tag_topic_id, :presence => true

  belongs_to :topics,
    primary_key: :id,
    foreign_key: :tag_topic_id,
    class_name: 'TagTopic'

  belongs_to :urls,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: 'ShortenedUrl'

end
