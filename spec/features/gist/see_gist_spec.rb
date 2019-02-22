require 'rails_helper'

feature 'If the link lead to gist, the gist content should be displayed' do
  context 'displayed gist content' do
    given(:question) { create(:question, :with_quest_gist) }
    given(:answer) { create(:answer, :with_answer_gist) }

    scenario 'for question' do
      sign_in(question.author)
      visit question_path(question)

      within '.question' do
        expect(page).to have_content 'Что вернет следующие выражание? 57 / 0'
      end
    end

    scenario 'for answer' do
      sign_in(answer.author)
      visit question_path(answer.question)

      within '.answer' do
        expect(page).to have_content 'Что вернет следующие выражание? 57 / 0'
      end
    end
  end

  context 'error gist' do
    given(:question) { create(:question, :with_quest_error_gist) }
    given(:answer) { create(:answer, :with_answer_error_gist) }

    scenario 'for question' do
      sign_in(question.author)
      visit question_path(question)

      within '.question' do
        expect(page).to have_content '404 Not Found GIST'
      end
    end

    scenario 'for answer' do
      sign_in(answer.author)
      visit question_path(answer.question)

      within '.answer' do
        expect(page).to have_content '404 Not Found GIST'
      end
    end
  end
end
