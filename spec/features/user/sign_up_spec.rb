require 'rails_helper'

feature 'User can registration', "
  Valid attributes
  Invalid attributes
" do

  background { visit new_user_registration_path }
  given(:user) { build(:user) }

  scenario 'User Sing Up with valid attributes' do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_on 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  scenario 'User Sing Up with invalid attributes' do
    click_on 'Sign up'

    expect(page).to have_content '2 errors prohibited this user from being saved:'
    expect(page).to have_content "Email can't be blank"
    expect(page).to have_content "Password can't be blank"
  end

end