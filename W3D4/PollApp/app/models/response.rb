# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  answer_choice_id :integer          not null
#  user_id          :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#

class Response < ActiveRecord::Base

  validate :respondent_already_answered, :respond_own_poll

  belongs_to :answer_choice,
    class_name: 'AnswerChoice',
    foreign_key: :answer_choice_id,
    primary_key: :id

  belongs_to :respondent,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id

  has_one :question,
    through: :answer_choice,
    source: :question


  def sibling_responses
    self.question.responses.where.not(id: self.id)
  end

  def respondent_already_answered
    if self.sibling_responses.exists?(user_id: self.user_id)
      errors[:user_id] << "can't respond twice to the same poll!"
    end
  end

  def respond_own_poll
    if self.question.poll.author_id == self.user_id
      errors[:user_id] << "can't answer your own poll!"
    end
  end


end
