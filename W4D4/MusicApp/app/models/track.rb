# == Schema Information
#
# Table name: tracks
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  album_id    :integer          not null
#  description :text
#  status      :string           not null
#

class Track < ActiveRecord::Base
  validates :name, presence:true
  validates :album_id, presence:true
  validates :status, presence:true, inclusion:{in:['bonus', 'regular']}

  belongs_to :album,
    primary_key: :id,
    foreign_key: :album_id,
    class_name: 'Album'

  has_one :band,
    through: :album,
    source: :band

  has_many :notes,
    primary_key: :id,
    foreign_key: :track_id,
    class_name: 'Note'
end
