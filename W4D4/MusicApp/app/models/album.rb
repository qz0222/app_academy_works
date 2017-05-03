# == Schema Information
#
# Table name: albums
#
#  id      :integer          not null, primary key
#  name    :string           not null
#  band_id :integer          not null
#  status  :string           not null
#

class Album < ActiveRecord::Base
  validates :name, presence:true
  validates :band_id, presence:true
  validates :status, presence:true, inclusion:{in:['live', 'studio']}

  belongs_to :band,
    primary_key: :id,
    foreign_key: :band_id,
    class_name: 'Band'

  has_many :tracks,
    dependent: :destroy,
    primary_key: :id,
    foreign_key: :album_id,
    class_name: 'Track'
end
