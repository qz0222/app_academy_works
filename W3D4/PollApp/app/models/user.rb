# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base

  # validate:

  has_many :authored_polls,
    class_name: 'Poll',
    foreign_key: :author_id,
    primary_key: :id

  has_many :responses,
    class_name: 'Response',
    foreign_key: :user_id,
    primary_key: :id

  def completed_polls

  end

  # User.find_by_sql(<<-SQL)
  #   SELECT
  #     polls.title
  #   FROM
  #     polls
  #     JOIN
  #     questions ON questions.poll_id = polls.id
  #     JOIN
  #     answer_choices ON answer_choices.question_id = questions.id
  #     JOIN
  #     responses ON responses.answer_choice_id = answer_choices.id
  #   WHERE
  #     responses.user_id = 3
  # SQL







end
