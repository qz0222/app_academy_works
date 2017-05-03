# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  session_token   :string           not null
#  password_digest :string           not null
#

class User < ActiveRecord::Base
  validates :email, presence:true, uniqueness:true
  validates :session_token, presence:true
  validates :password_digest, presence:true

  after_initialize :ensure_session_token

  has_many :notes,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: 'Note'


  def self.generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  def ensure_session_token
    unless self.session_token
      self.session_token = User.generate_session_token
    end
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(email, password)

    user = User.find_by(email: email)
    if user && user.is_password?(password)
      user
    else
      nil
    end
  end


end
