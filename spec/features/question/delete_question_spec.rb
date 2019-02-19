require 'rails_helper'

feature 'User can delete own question' do

  given(:question_own) { create(:question) }
  given(:question_foreign) { create(:question) }

  context 'Authenticate user' do
    background { sign_in(question_own.author) }

    context 'Own question' do
      background { visit question_path(question_own) }

      scenario 'Authenticated user' do
        click_on 'Delete question'

        expect(page).to_not have_content question_own.body
      end
    end

    scenario 'Authenticated user delete foreign question' do
      visit question_path(question_foreign)

      expect(page).to_not have_link 'Delete question'
    end


    context 'Un authenticate user' do
      scenario 'User not can delete foreign answer' do
        visit question_path(question_foreign)

        expect(page).to_not have_link 'Delete question'
      end
    end
  end
end
