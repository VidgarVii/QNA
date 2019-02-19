require 'rails_helper'

feature 'Author of the question can choose the best answer', "
  The best answer can be only one
  Author of the question can change the best answer
  The best answer  always first in the list answers
" do

  given(:user) { create(:user) }
  given(:question) { create(:question, :with_answers) }
  given(:btn_last_answer) { page.all("input.btn.best") }

  context 'Own question' do
    background do
      sign_in(question.author)
      visit question_path(question)
    end

    scenario 'user choose best answer. Best answer becomes the first in the list', js: true do
      btn_last_answer.last.click

      sleep 2
      expect(page.all("ul.answers_list li").first).to have_content question.answers.last.body
      expect(page.all("ul.answers_list li").last).to_not have_content question.answers.last.body
    end
  end

  context 'Foreign question' do
    background do
      visit question_path(question)
    end

    scenario 'user unable choose best answer' do
      sign_in(user)

      expect(page).to_not have_selector('input', text: 'Best')
    end

    scenario 'unauthenticated user' do
      expect(page).to_not have_selector('input', text: 'Best')
    end
  end
end
