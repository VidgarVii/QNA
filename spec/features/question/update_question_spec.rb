require 'rails_helper'

feature 'User can edit own question' do
  given(:user) { create(:user) }
  given(:question) { create(:question) }

  context 'Own question' do

    background do
      sign_in(question.author)
      visit question_path(question)
    end

    scenario 'valid attributes' do
      click_on 'Edit Question'

      within '.update_question' do
        fill_in 'Title', with: 'New Title'
        fill_in 'Body', with: 'New Body'
        click_on 'Save'
      end

      expect(page).to have_selector '.update_question', visible: false
      expect(page).to_not have_content question.body
      expect(page).to_not have_content question.title
      expect(page).to have_content 'New Title'
      expect(page).to have_content 'New Body'
    end

    scenario 'invalid attributes'
  end

  context 'Foreign question' do
    scenario 'authenticated user' do
      sign_in(user)
      visit question_path(question)

      expect(page).to_not have_content 'Edit Question'
    end

    scenario 'unauthenticated user' do
      visit question_path(question)

      expect(page).to_not have_content 'Edit Question'
    end
  end
end