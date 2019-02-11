require 'rails_helper'

feature 'User can sign in', "
  In order to ask question
  As an unauthenticated user
  I'd like to be able to sign in
" do

  given(:user) { create(:user) }

  background { visit new_user_session_path }

  scenario 'Registrered user tries to sign in' do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    expect(page).to have_content 'Signed in successfully.'
  end

  scenario 'Unregistrered user tries to sign in' do
    fill_in 'Email', with: 'wrong@mail.ru'
    fill_in 'Password', with: 'qwerty'
    click_on 'Log in'

    expect(page).to have_content 'Invalid Email or password.'
  end
end
