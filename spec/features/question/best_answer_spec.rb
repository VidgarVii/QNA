require 'rails_helper'

feature 'Author of the question can choose the best answer', "
  The best answer can be only one
  Author of the question can change the best answer
  The best answer  always first in the list answers
" do

  given(:question) { create(:question, :with_answers) }
  given(:btn_last_answer) { page.first(:xpath, "//button[@data-id='#{question.answers.last.id}']") }

  background do
    sign_in(question.author)
    visit question_path(question)
  end

  scenario 'user choose best answer' do
    btn_last_answer.click

    expect(page.all("ul.answers_list li").first).to have_content question.answers.last.body
  end
end