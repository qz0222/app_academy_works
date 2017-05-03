# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.destroy_all
Poll.destroy_all
Question.destroy_all
AnswerChoice.destroy_all
Response.destroy_all

User.create!(id: 1, name: "Muhammad")
User.create!(id: 2, name: "Zheng")
User.create!(id: 3, name: "Obama")
User.create!(id: 4, name: "Trump")
Poll.create!(id: 1, title: "favorite food", author_id: User.find_by_name("Muhammad").id)
Poll.create!(id: 2, title: "favorite color", author_id: User.find_by_name("Zheng").id)
Question.create!(id: 1, question_text: "What is your favorite food?", poll_id: 1)
Question.create!(id: 3, question_text: "What is your favorite drink?", poll_id: 1)
Question.create!(id: 2, question_text: "What is your favorite color?", poll_id: 2)
Question.create!(id: 4, question_text: "What is your favorite city?", poll_id: 1)
AnswerChoice.create!(id: 1, answer_text: "banana", question_id: 1)
AnswerChoice.create!(id: 2, answer_text: "apple", question_id: 1)
AnswerChoice.create!(id: 3, answer_text: "chicken", question_id: 1)
AnswerChoice.create!(id: 4, answer_text: "pizza", question_id: 1)
AnswerChoice.create!(id: 5, answer_text: "black", question_id: 2)
AnswerChoice.create!(id: 6, answer_text: "white", question_id: 2)
AnswerChoice.create!(id: 7, answer_text: "red", question_id: 2)
AnswerChoice.create!(id: 8, answer_text: "blue", question_id: 2)
AnswerChoice.create!(id: 9, answer_text: "water", question_id: 3)
AnswerChoice.create!(id: 10, answer_text: "milk", question_id: 3)
AnswerChoice.create!(id: 11, answer_text: "New York", question_id: 4)
AnswerChoice.create!(id: 12, answer_text: "Jersey City", question_id: 4)
Response.create!(id: 1, answer_choice_id: 3, user_id: 2)
Response.create!(id: 2, answer_choice_id: 4, user_id: 3)
Response.create!(id: 3, answer_choice_id: 1, user_id: 4)
Response.create!(id: 4, answer_choice_id: 5, user_id: 1)
Response.create!(id: 5, answer_choice_id: 8, user_id: 3)
Response.create!(id: 6, answer_choice_id: 8, user_id: 4)
Response.create!(id: 7, answer_choice_id: 9, user_id: 3)
Response.create!(id: 8, answer_choice_id: 11, user_id: 3)
Response.create!(id: 9, answer_choice_id: 11, user_id: 4)
