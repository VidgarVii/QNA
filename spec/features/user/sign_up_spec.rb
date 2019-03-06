require 'rails_helper'

feature 'User can registration', "
  To ask a question
  To answer the question
" do

  background { visit new_user_registration_path }
  given(:user) { build(:user) }

  scenario 'User Sing Up with valid attributes', js: true do
    clear_emails

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_on 'Sign up'

    sleep 1
    open_email(user.email)
    current_email.click_link 'Confirm my account'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    expect(page).to have_content user.email
    expect(page).to have_content 'Exit'
  end

  scenario 'User Sing Up with invalid attributes' do
    click_on 'Sign up'

    expect(page).to have_content '2 errors prohibited this user from being saved:'
    expect(page).to have_content "Email can't be blank"
    expect(page).to have_content "Password can't be blank"
  end

end