require 'rails_helper'

feature 'User can delete own answer' do

  given(:answer_own) { create(:answer) }
  given(:answer_foreign) { create(:answer) }

  context 'Authenticate user' do
    background { sign_in(answer_own.author) }

    scenario 'delete own answer', js: true do
      visit question_path(answer_own.question)

      accept_confirm do
        click_on 'Delete answer'
      end

      expect(page).to_not have_content answer_own.body
    end

    scenario 'not can delete foreign answer' do
      visit question_path(answer_foreign.question)

      expect(page).to_not have_link 'Delete answer'
    end

    context 'Un authenticate user' do
      scenario 'User not can delete foreign answer' do
        visit question_path(answer_foreign.question)

        expect(page).to_not have_link 'Delete answer'
      end
    end
  end
end
