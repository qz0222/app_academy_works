require_relative "visit"
# == Schema Information
#
# Table name: tag_topics
#
#  id    :integer          not null, primary key
#  topic :string
#

class TagTopic < ActiveRecord::Base
  validates :topic, :presence => true, :uniqueness => true

  has_many :taggings,
    primary_key: :id,
    foreign_key: :tag_topic_id,
    class_name: 'Tagging'

  has_many :urls,
    through: :taggings,
    source: :urls

  def popular_links
    Visit.select(:shortened_url_id).group(:shortened_url_id).order('COUNT(user_id) desc').limit(5)
  end
end
