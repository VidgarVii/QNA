require 'rails_helper'

feature 'User can create question', "
  In order to get answer from a community
  As an authenticated user
  I'd like to be able to ask the question
" do

  context 'Authenticated user' do
    given(:user) { create(:user) }

    background do
      sign_in(user)

      visit questions_path
      click_on 'Ask question'
    end

    scenario 'asks a question' do
      fill_in 'Title', with: 'Some Title'
      fill_in 'Body', with: 'Text'
      click_on 'Ask'

      expect(page).to have_content 'Your question successfully create.'
      expect(page).to have_content 'Some Title'
      expect(page).to have_content 'Text'
      expect(page).to have_content  "author: #{user.email}"
    end

    scenario 'asks a question with errors' do
      click_on 'Ask'

      expect(page).to have_content "Title can't be blank"
      expect(page).to have_content "Body can't be blank"
    end

    scenario 'asks a question with attached files' do
      fill_in 'Title', with: 'Some Title'
      fill_in 'Body', with: 'Text'
      attach_file 'Files', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
      click_on 'Ask'

      expect(page).to have_link 'rails_helper.rb'
      expect(page).to have_link 'spec_helper.rb'
    end
  end

  scenario 'Unauthenticated user to ask a question' do
    visit questions_path
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  context "mulitple sessions" do
    given(:user) { create(:user) }

    scenario "question appears on another user's page", js: true do
      using_session('user') do
        sign_in(user)
        visit questions_path
      end

      using_session('guest') do
        visit questions_path
      end

      using_session('user') do
        click_on 'Ask question'
        fill_in 'Title', with: 'Some Title'
        fill_in 'Body', with: 'Text'
        click_on 'Ask'

        expect(page).to have_content 'Your question successfully create.'
        expect(page).to have_content 'Some Title'
        expect(page).to have_content 'Text'
      end

      using_session('guest') do
        expect(page).to have_content 'Some Title'
      end
    end
  end
end
