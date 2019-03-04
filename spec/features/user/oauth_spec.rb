require 'rails_helper'

feature 'User can sign IN/UP with Vkontakte  account' do

  context ' Sign up' do
    before { visit new_user_registration_path }

    it 'VK', js: true do
      click_on "Sign in with Vkontakte"

      expect(page).to have_content'Hello mail@mail.ru'
      expect(page).to have_content'Exit'
    end

    it 'Github', js: true do
      click_on "Sign in with GitHub"

      expect(page).to have_content'Hello mail@mail.ru'
      expect(page).to have_content'Exit'
    end
  end

  context 'Sign in' do
    let!(:user) {create(:user, email: 'mail@mail.ru') }

    before { visit new_user_session_path }

    it 'VK', js: true do
      click_on "Sign in with Vkontakte"

      expect(page).to have_content'Hello mail@mail.ru'
      expect(page).to have_content'Exit'
    end

    it 'GitHub', js: true do
      click_on "Sign in with GitHub"

      expect(page).to have_content'Hello mail@mail.ru'
      expect(page).to have_content'Exit'
    end
  end
end
