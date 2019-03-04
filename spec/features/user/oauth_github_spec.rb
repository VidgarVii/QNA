require 'rails_helper'

feature 'Vkontakte sign IN/UP' do
  it 'user can sign in with Vkontakte account', js: true do
    visit new_user_session_path

    mock_auth_hash
    click_on "Sign in with Vkontakte"

    sleep 10
    expect(page).to have_content'Hello mail@mail.ru'
    expect(page).to have_content'Exit'
  end
end
