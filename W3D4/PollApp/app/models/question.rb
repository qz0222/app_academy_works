# == Schema Information
#
# Table name: questions
#
#  id            :integer          not null, primary key
#  poll_id       :integer          not null
#  question_text :text             not null
#  created_at    :datetime
#  updated_at    :datetime
#

class Question < ActiveRecord::Base

  belongs_to :poll,
    class_name: 'Poll',
    foreign_key: :poll_id,
    primary_key: :id

  has_many :answer_choices,
    class_name: 'AnswerChoice',
    foreign_key: :question_id,
    primary_key: :id

  has_many :responses,
    through: :answer_choices,
    source: :responses

  def slow_results
    result = {}
    choices = self.answer_choices
    choices.each do |choice|
      result[choice.answer_text] = choice.responses.count
    end
    result
  end


  def results
    result = {}
    choices = self.answer_choices.select(:answer_text).joins("LEFT OUTER JOIN (?)", self.responses).group(:answer_text)
    choices.each do |choice|
      result[choice.answer_text] = choice.responses.length
    end
    result
  end


  # Question.find_by_sql(<<-SQL)
  #   SELECT
  #     answer_choices.answer_text, COUNT(*) AS total
  #   FROM
  #     questions
  #     JOIN
  #     answer_choices ON questions.id = answer_choices.question_id
  #     LEFT OUTER JOIN
  #     responses ON responses.answer_choice_id = answer_choices.id
  #     WHERE
  #     question_id = 1
  #     GROUP BY
  #     answer_choices.answer_text
  # SQL







end
