# == Schema Information
#
# Table name: post_subs
#
#  id         :integer          not null, primary key
#  sub_id     :integer          not null
#  post_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PostSub < ApplicationRecord

  validates :post, :sub, presence: true

  belongs_to :post,
    # inverse_of: :post_subs,
    primary_key: :id,
    foreign_key: :post_id,
    class_name: 'Post'

  belongs_to :sub,
    # inverse_of: :post_subs,
    primary_key: :id,
    foreign_key: :sub_id,
    class_name: 'Sub'

end
