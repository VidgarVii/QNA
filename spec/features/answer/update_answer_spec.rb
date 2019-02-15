require 'rails_helper'

feature 'User can update own answer' do
  given(:user) { create(:user) }
  given(:answer) { create(:answer) }

  describe 'User can edit own answer' do
    background do
      sign_in(answer.author)
      visit question_path(answer.question)
    end

    scenario 'valid attribute', js: true do
      click_on 'Edit'

      within '.answer' do
        fill_in 'Body', with: 'Edited answer'
        click_on 'Save'

        expect(page).to_not have_selector 'textarea'
        expect(page).to_not have_content answer.body
        expect(page).to have_content 'Edited answer'
      end
    end

    scenario 'invalid attribute', js: true do
      click_on 'Edit'

      within '.answer' do
        fill_in 'Body', with: ''
        click_on 'Save'

        expect(page).to have_selector 'textarea'
        expect(page).to have_content "Body can't be blank"
      end
    end
  end

  describe 'User can not edit foreign answer' do
    scenario 'Unauthenticated user' do
      visit question_path(answer.question)

      expect(page).to_not have_link 'Edit'
    end

    scenario 'Authenticated user' do
      sign_in(user)
      visit question_path(answer.question)

      within '.answer' do
        expect(page).to_not have_link 'Edit'
      end
    end
  end
end
