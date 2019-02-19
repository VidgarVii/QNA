require 'rails_helper'

feature 'User can edit own question' do
  given(:user) { create(:user) }
  given(:question) { create(:question) }

  context 'Own question' do

    background do
      sign_in(question.author)
      visit question_path(question)
      click_on 'Edit question'
    end

    scenario 'valid attributes', js: true do

      within '.question' do
        fill_in 'Title', with: 'New Title'
        fill_in 'Body', with: 'New Body'
        attach_file 'Files', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
        click_on 'Save'
      end

      expect(page).to_not have_selector '.edit_question_form'
      expect(page).to_not have_content question.body
      expect(page).to_not have_content question.title
      expect(page).to have_content 'New Title'
      expect(page).to have_content 'New Body'
      expect(page).to have_link 'rails_helper.rb'
      expect(page).to have_link 'spec_helper.rb'
    end

    scenario 'invalid attributes', js: true do
      within '.question' do
        fill_in 'Title', with: ''
        fill_in 'Body', with: ''
        click_on 'Save'

        expect(page).to have_content "2 error(s) detected"
        expect(page).to have_content "Title can't be blank"
        expect(page).to have_content "Body can't be blank"
      end
    end
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