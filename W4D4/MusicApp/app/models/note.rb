# == Schema Information
#
# Table name: notes
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  track_id   :integer          not null
#  body       :text
#  created_at :datetime
#  updated_at :datetime
#

class Note < ActiveRecord::Base

  belongs_to :user,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: 'User'

  belongs_to :track,
    primary_key: :id,
    foreign_key: :track_id,
    class_name: 'Track'

end
