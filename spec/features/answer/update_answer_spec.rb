require 'rails_helper'

feature 'User can update own answer' do
  given(:user) { create(:user) }
  given(:answer) { create(:answer) }

  describe 'User can edit own answer' do
    background do
      sign_in(answer.author)
      visit question_path(answer.question)
      click_on 'Edit'
    end

    scenario 'valid attribute', js: true do
      within '.answer' do
        fill_in 'Body', with: 'Edited answer'
        attach_file 'Files', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
        click_on 'Save'

        expect(page).to_not have_selector 'textarea'
        expect(page).to_not have_content answer.body
        expect(page).to have_content 'Edited answer'
        expect(page).to have_link 'rails_helper.rb'
        expect(page).to have_link 'spec_helper.rb'
      end
    end

    scenario 'invalid attribute', js: true do
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
