require 'rails_helper'

feature 'User can create question', "
  In order to get answer from a community
  As an authenticated user
  I'd like to be able to ask the question
" do

  describe 'Authenticated user' do

    background do
      sign_in(user)

      visit questions_path
      click_on 'Ask question'
    end

    given(:user) { create(:user) }
    scenario 'asks a question' do
      fill_in 'Title', with: 'Some Title'
      fill_in 'Body', with: 'Text'
      click_on 'Ask'

      expect(page).to have_content 'Your question successfully create.'
      expect(page).to have_content 'Some Title'
      expect(page).to have_content 'Text'
    end

    scenario 'asks a question with errors' do
      click_on 'Ask'

      expect(page).to have_content "Title can't be blank"
      expect(page).to have_content "Body can't be blank"
    end

  end

  scenario 'Unauthenticated user to ask a question' do
    visit questions_path
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
