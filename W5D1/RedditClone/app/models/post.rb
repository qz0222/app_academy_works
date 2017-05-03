# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord
  validates :title, :author, presence:true

  belongs_to :author,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: 'User'

  has_many :post_subs,
  dependent: :destroy,
  inverse_of: :post,
    primary_key: :id,
    foreign_key: :post_id,
    class_name: 'PostSub'

  has_many :comments,
    primary_key: :id,
    foreign_key: :post_id,
    class_name: 'Comment'

  has_many :subs,
    through: :post_subs,
    source: :sub


  def comments_by_parent_id
    all_comments = self.comments
    result = Hash.new{[]}
    all_comments.each do |comment|
      result[comment.parent_comment_id] = result[comment.parent_comment_id] << comment
    end
    result
  end

  # @all_comments = @post.comments_by_parent_id

  def self.show_nested_comments(all_comments, current_comment)
    puts current_comment.content
    all_comments[current_comment.id].each do |comment|
      Post.show_nested_comments(all_comments, comment)
    end
  end

end
