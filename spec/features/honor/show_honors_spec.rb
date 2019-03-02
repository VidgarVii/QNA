require 'rails_helper'

feature 'User can show own honors' do
  given(:question) { create(:question, :with_honor) }
  given(:author) { question.author }
  given!(:answer) { create(:answer, author: author, question: question) }

  context 'Have honor' do
    background do
      sign_in(author)
      visit question_path(question)
    end

    scenario 'visit honors page', js: true do
      click_on 'Best'
      sleep 2
      visit honors_path

      expect(page).to have_content author.honors.first.name
      expect(page).to have_content author.honors.first.question.title
      expect(page.find('img')['src']).to have_content 'blob'
    end
  end

  context 'Empty honor' do
    given!(:user) { create(:user) }

    scenario 'visit honors page (empty honor)', js: true do
      sign_in(user)
      visit honors_path
      sleep 5

      expect(page).to have_content 'Honors'
    end
  end
end
