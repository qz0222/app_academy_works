# == Schema Information
#
# Table name: comments
#
#  id                :integer          not null, primary key
#  content           :text             not null
#  user_id           :integer          not null
#  post_id           :integer          not null
#  parent_comment_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Comment < ApplicationRecord

  belongs_to :parent_comment,
    optional: true,
    primary_key: :id,
    foreign_key: :parent_comment_id,
    class_name: 'Comment'

  has_many :child_comments,
    primary_key: :id,
    foreign_key: :parent_comment_id,
    class_name: 'Comment'

  belongs_to :post,
    primary_key: :id,
    foreign_key: :post_id,
    class_name: 'Post'

  belongs_to :user,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: 'User'

end
