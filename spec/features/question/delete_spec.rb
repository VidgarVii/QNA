require 'rails_helper'

feature 'User can delete own question' do

  given(:question_own) { create(:question) }
  given(:question_foreign) { create(:question) }

  background { sign_in(question_own.author) }

  context 'Own question' do
    background { visit question_path(question_own) }

    scenario 'Delete button should exists for authenticated user' do
      expect(page.has_css?('a[data-method="delete"]', text: 'Delete question')).to be_truthy
    end

    scenario 'Authenticated user delete question' do
      click_on 'Delete question'

      expect(page).to have_content 'Ask question'
    end
  end

  scenario 'Authenticated user delete foreign question' do
    visit question_path(question_foreign)

    expect(page.has_css?('a[data-method="delete"]', text: 'Delete question')).to be_falsey
  end
end
