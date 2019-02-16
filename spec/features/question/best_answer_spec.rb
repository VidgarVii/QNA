require 'rails_helper'

feature 'Author of the question can choose the best answer', "
  The best answer can be only one
  Author of the question can change the best answer
  The best answer  always first in the list answers
" do

  given(:question) { create(:question, :with_answers) }
  given(:btn_last_answer) { page.first(:xpath, "//input[@data-id='#{question.answers.last.id}']") }

  background do
    sign_in(question.author)
    visit question_path(question)
  end

  scenario 'user choose best answer', js: true do
    btn_last_answer.click

    sleep 1
    expect(page.all("ul.answers_list li").first).to have_content question.answers.last.body
    expect(page.all("ul.answers_list li").last).to_not have_content question.answers.last.body
  end
end