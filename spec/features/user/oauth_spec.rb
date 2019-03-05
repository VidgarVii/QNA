require 'rails_helper'

feature 'User can sign IN/UP with Socials  account' do

  context ' Sign up' do
    before { visit new_user_registration_path }

    scenario 'VK', js: true do
      click_on "Sign in with Vkontakte"

      expect(page).to have_content'Hello mail@mail.ru'
      expect(page).to have_content'Exit'
    end

    scenario 'Github', js: true do
      click_on "Sign in with GitHub"

      expect(page).to have_content'Hello mail@mail.ru'
      expect(page).to have_content'Exit'
    end

    scenario 'Instagram', js: true do
      clear_emails

      click_on "Sign in with Instagram"

      fill_in 'Email', with: 'mail2@mail.ru'
      click_on 'Update User'
      sleep 2
      open_email('mail2@mail.ru')
      current_email.click_link 'Confirm my account'

      expect(page).to have_content'Hello mail2@mail.ru'
      expect(page).to have_content'Exit'
    end
  end

  context 'Sign in' do
    let!(:user) { create(:user, email: 'mail@mail.ru') }

    before { visit new_user_session_path }

    scenario 'VK', js: true do

      click_on "Sign in with Vkontakte"

      expect(page).to have_content'Hello mail@mail.ru'
      expect(page).to have_content'Successfully authenticated from Vkontakte'
    end

    scenario 'GitHub', js: true do
      click_on "Sign in with GitHub"

      expect(page).to have_content'Hello mail@mail.ru'
      expect(page).to have_content'Exit'
    end

    scenario 'Instagram', js: true do
      clear_emails

      click_on "Sign in with Instagram"

      fill_in 'Email', with: 'mail@mail.ru'
      click_on 'Update User'

      expect(page).to have_content 'Email has already been taken'
    end
  end
end
