require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { FactoryGirl.create(:user, password_digest: "asdfadf") }

  describe "associations" do
  end

  describe "validations" do

    it "always makes username unique" do
      should validate_uniqueness_of(:username)
    end

    context "checks presence of" do

      it "username" do
        should validate_presence_of(:username)
      end

      it do
        should validate_presence_of(:password_digest)
      end
    end

    it "ensures that a session_token is created" do
      expect(user.session_token).not_to be(nil)
    end

  end



  describe "instance methods" do
    let!(:user2) { FactoryGirl.create(:user, password: "test") }

    context "#password=()" do
      it "sets up a password digest" do
        expect(user2.password_digest).not_to be(nil)
      end

      it "uses BCrypt to generate password_digest" do
        ans = BCrypt::Password.new(user2.password_digest).is_password?("test")
        expect(ans).to be(true)
      end

      it "never saves the original password" do
        expect(user2.attributes.has_value?("test")).to be(false)
      end

    end

    context "#is_password?()" do

      it "returns true for the correct password" do
        expect(user2.is_password?("test")).to be(true)
      end

      it "returns false for the incorrect password" do
        expect(user2.is_password?("asdf")).to be(false)
      end

    end

    context "#reset_session_token!" do

      it "re-assigns the user's session_token attribute" do
        previous_session_token = user2.session_token
        user2.reset_session_token!

        expect(user2.session_token).not_to eq(previous_session_token)
      end

      it "saves the user" do
        user2.reset_session_token!
        expect(User.find_by(session_token: user2.session_token)).to eq(user2)
      end

      it "returns the new session token" do
        expect(user2.reset_session_token!).to eq(user2.session_token)
      end


    end

  end



  describe "class methods" do

    context "find_by_credentials" do
      user = FactoryGirl.create(:user, username: "asdf", password:"asdfasdf")

      it "finds a user with valid input" do
        expect(User.find_by_credentials("asdf","asdfasdf")).to eq(user)
      end

      it "returns nil with invalid username" do
        expect(User.find_by_credentials("asadf","asdfasdf")).to be(nil)
      end

      it "returns nil with invalid password" do
        expect(User.find_by_credentials("asdf","asdffsdfasdf")).to be(nil)
      end

    end
  end

end




  # validations:
    # uniqueness: username
    # presence: username, password_digest
    # ensuring that a session token exists for the user as an attribute

  # associations
    #later

  # class methods
    # find_by_credentials(username, password)
    # generate_password_digest

  # instance methods
    # reset_session_token
      # re-assigns the user's session_token attribute
      # saves the user
      # returns the new session token

    # is_password?(password)
