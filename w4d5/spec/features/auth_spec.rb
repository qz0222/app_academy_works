require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
  end

  feature "signing up a user" do

    scenario "shows username on the homepage after signup" do
      visit new_user_url
      fill_in 'username', :with => 'testuser'
      fill_in 'password', :with => 'testpassword'

      click_on 'sign up'

      expect(page).to have_content "testuser"

    end

  end

end

feature "logging in" do

  scenario "shows username on the homepage after login" do
    user = User.new(username: 'testuser', password: 'testpassword')
    user.save
    visit new_session_url
    fill_in 'username', :with => 'testuser'
    fill_in 'password', :with => 'testpassword'

    click_on 'log in'

    expect(page).to have_content "testuser"
  end

end

feature "logging out" do

  scenario "begins with a logged out state" do

  end

  scenario "doesn't show username on the homepage after logout"

end
