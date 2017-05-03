# == Schema Information
#
# Table name: visits
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  shortened_url_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Visit < ActiveRecord::Base
  validates :user_id, :presence => true
  validates :shortened_url_id, :presence => true


  belongs_to :users,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: 'User'

  belongs_to :urls,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: 'ShortenedUrl'

  def self.record_visit!(user, shortened_url)
    Visit.create!(user_id:user.id, shortened_url_id:shortened_url.id)
  end
end
