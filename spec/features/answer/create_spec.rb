require 'rails_helper'

feature 'User can create answer', "
  In order to get answer from a community
  As an authenticated user
  I'd like to be able to ask the question
" do
  given(:question) { create(:question) }

  describe 'Authenticated user' do
    given(:user) { create(:user) }

    background do
      sign_in(user)

      visit question_path(question)
    end

    scenario 'asks a answer' do
      fill_in 'Body', with: 'New Answer!'
      click_on 'Answer'

      expect(page).to have_content 'Your answer successfully create.'
      expect(page).to have_content 'New Answer!'
    end

    scenario 'asks a answer with errors' do
      click_on 'Answer'

      expect(page).to have_content "Body can't be blank"
    end

  end

  scenario 'Unauthenticated user to ask a question' do
    visit question_path(question)
    fill_in 'Body', with: 'New Answer!'
    click_on 'Answer'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
