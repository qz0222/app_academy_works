require 'sqlite3'
require 'singleton'
require 'byebug'
require 'active_support/inflector'
class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true

  end
end

class SuperClass
  def self.all

    data = QuestionsDatabase.instance.execute("SELECT * FROM #{self.to_s.tableize}")
    data.map{|datum| self.new(datum)}
  end

  def self.find_by_id(id)

    items = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        self.to_s.tableize
      WHERE
        id = ?
    SQL

    return nil if items.length == 0

    self.new(items.first)
  end

  def save
    array = self.instance_variables
    array.delete(:@id)
    array.map!(&:to_s)
    array_data = array.map{|el|self.send(el.gsub("@",""))}
    columns = array.map{|el| el.gsub("@","") }

    if @id
      QuestionsDatabase.instance.execute(<<-SQL, array_data, @id)
        UPDATE
          #{self.class.to_s.tableize}
        SET
          #{columns.join(" = ? , ") + " = ?"}
        WHERE
          id = ?
      SQL
    else
      QuestionsDatabase.instance.execute(<<-SQL, array_data)
        INSERT INTO
          #{self.class.to_s.tableize}(#{columns.join(" , ")})
        VALUES
          (#{Array.new(array.size){"?"}.join(" , ")})

      SQL
      @id = QuestionsDatabase.instance.last_insert_row_id
    end
  end

  def self.where(options_hash)
    result = []
    options_hash.each do |key, value|
      result << "#{key} = '#{value}'"
    end
    items = QuestionsDatabase.instance.execute(<<-SQL)
        SELECT
          *
        FROM
          #{self.to_s.tableize}
        WHERE
          #{result.join(" OR ")}

    SQL

    items.map { |item| self.new(item) }
  end

end

class User < SuperClass

  attr_accessor :fname, :lname

  def self.find_by_name(fname, lname)
    user = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?
    SQL

    return nil if user.length == 0

    User.new(user.first)
  end

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Question.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def average_karma
    QuestionLike.liked_questions_for_user_id(user_id)
  end


end


class Question < SuperClass

  attr_accessor :title, :body, :author_id

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
    @dashboard = "questions"
  end


  def self.find_by_author_id(author_id)
    question = QuestionsDatabase.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        author_id = ?
    SQL

    return nil if question.length == 0

    question.map{|el| Question.new(el)}
  end


  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def author
    User.find_by_id(@author_id)
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def followers
    QuestionFollow.followers_for_question_id(@id)
  end

  def likers
    QuestionLike.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end





end



class Reply < SuperClass

  attr_accessor :question_id, :user_id, :parent_id, :body

  def self.find_by_question_id(question_id)
    reply = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?
    SQL

    return nil if reply.length == 0

    reply.map { |el| Reply.new(el) }
  end

  def self.find_by_user_id(user_id)
    reply = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = ?
    SQL

    return nil if reply.length == 0

    reply.map{|el| Reply.new(el)}
  end

  def author
    User.find_by_id(@user_id)
  end

  def question
    Question.find_by_id(@question_id)
  end

  def parent_reply
    Reply.find_by_id(@parent_id)
  end

  def child_reply
    child = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_id = ?
    SQL

    return nil if child.length == 0
    Reply.new(child.first)
  end


  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @parent_id = options['parent_id']
    @user_id = options['user_id']
    @body = options['body']
    @dashboard = "replies"
  end

end

class QuestionFollow
  def self.followers_for_question_id(question_id)
    users = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      *
    FROM
      users
    JOIN
      question_follows
    ON
      users.id = question_follows.user_id
    JOIN
      questions
    ON
      question_follows.question_id = questions.id
    WHERE
     questions.id = ?

   SQL

   users.map { |user| User.new(user) }

  end

  def self.followed_questions_for_user_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        questions
      JOIN
        question_follows
      ON
        question_follows.question_id = questions.id
      JOIN
        users
      ON
        question_follows.user_id = users.id
      WHERE
        users.id = ?
    SQL

    questions.map { |question| Question.new(question) }
  end

  def self.most_followed_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        *
      FROM
        questions
      JOIN
        question_follows
      ON
        question_follows.question_id = questions.id
      GROUP BY
        question_id
      ORDER BY
        COUNT(user_id) DESC
      LIMIT
        ?
    SQL
    questions.map{ |question| Question.new(question)}
  end
end

class QuestionLike

  def self.likers_for_question_id(question_id)
    likes = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        users
      JOIN
        question_likes
      ON
        users.id = question_likes.user_id
      WHERE
        question_likes.question_id = ?

    SQL

    likes.map { |like| User.new(like) }
  end

  def self.num_likes_for_question_id(question_id)
    likes = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        COUNT(user_id)
      FROM
        questions
      JOIN
        question_likes
      ON
        questions.id = question_likes.question_id
      GROUP BY
        question_id

    SQL

    likes
  end

  def self.liked_questions_for_user_id(user_id)
    questions = QuestionsDatabase.instance.execture(<<-SQL, user_id)
      SELECT
        *
      FROM
        questions
      JOIN
        question_likes
      ON
        questions.id = question_likes.question_id
      WHERE
        question_likes.user_id = ?
    SQL

    questions.map { |question| Question.new(question) }
  end

  def self.liked_questions_for_user_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        CAST(COUNT(question_likes.user_id) AS FLOAT) / COUNT(DISTINCT(questions.id))
      FROM
        questions
      LEFT OUTER JOIN
        question_likes
      ON
        questions.id = question_likes.question_id
      WHERE
        questions.author_id = ?
    SQL

    questions
  end

  def self.most_liked_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        *
      FROM
        questions
      JOIN
        question_likes
      ON
        question_likes.question_id = questions.id
      GROUP BY
        question_id
      ORDER BY
        COUNT(user_id) DESC
      LIMIT
        ?
    SQL
    questions.map{ |question| Question.new(question)}
  end



  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end


end

test_user = User.new({"id" => 1, "fname" => "Alex", "lname" => "Boring"})
test_question = Question.new({"id"=>1, "title"=>"WHERE", "body"=>"Where am I?", "author_id"=>1})
test_reply = Reply.new({"id"=>1, "question_id"=>1, "parent_id"=>nil, "user_id"=>2, "body"=>"You are in New York?"})
