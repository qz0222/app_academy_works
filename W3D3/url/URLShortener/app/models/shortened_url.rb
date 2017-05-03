require 'securerandom'
require_relative 'Visit'
# == Schema Information
#
# Table name: shortened_urls
#
#  id        :integer          not null, primary key
#  long_url  :string
#  short_url :string
#  user_id   :integer
#

class ShortenedUrl < ActiveRecord::Base
  validates :long_url, :presence => true, :uniqueness => true

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: 'User'

  has_many :taggings,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: 'Tagging'

  has_many :visits,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: 'Visit'

  has_many :topics,
    through: :taggings,
    source: :topics

  has_many :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :users

  def self.random_code
    random_string = SecureRandom.urlsafe_base64
    while ShortenedUrl.exists?(:short_url => random_string)
      random_string = SecureRandom::urlsafe_base64
    end
    random_string
  end

  def self.make(user, long_url)
    ShortenedUrl.create!(user_id:user.id, long_url:long_url, short_url:ShortenedUrl.random_code)
  end

  def num_recent_uniques
    Visit.select(:user_id).distinct.where('created_at >= ?', 10.minutes.ago).where('shortened_url_id = ?', self.id, ).count
  end

  def num_clicks
    self.visits.size
  end

  def num_uniques
    self.visitors.size
  end

end
