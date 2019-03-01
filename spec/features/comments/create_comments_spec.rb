require 'rails_helper'

feature 'Authenticated user can create comments for questions/answers' do
  given(:user) { create(:user) }
  given(:question) { create(:question) }

  context 'For Question' do

    background do
      sign_in(user)

      visit question_path(question)
    end

    scenario 'create comment', js: true do
      click_on 'add a comment'

      fill_in 'comment', with: 'Some comment'
      click_on 'Comment'

      expect(page.find('form.comment')).to_not be_visible

      within '.comments' do
        expect(page).have_content 'Some comment'
      end
    end
  end
end
