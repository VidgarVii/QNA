require 'rails_helper'

feature 'User can delete own answer' do

  given(:answer_own) { create(:answer) }
  given(:answer_foreign) { create(:answer) }

  background { sign_in(answer_own.author) }

  context 'Own answer' do
    background { visit question_path(answer_own.question) }

    scenario 'Delete button should exists' do
      expect(page.has_css?('a[data-method="delete"]', text: 'Delete answer')).to be_truthy
    end

    scenario 'User delete answer' do
      click_on 'Delete answer'

      expect(page).to have_content answer_own.question.title
    end
  end

  scenario 'User not can delete foreign answer' do
    visit question_path(answer_foreign.question)

    expect(page.has_css?('a[data-method="delete"]', text: 'Delete answer')).to be_falsey
  end
end
