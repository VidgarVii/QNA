require 'rails_helper'

feature 'User can see questions', "
  User can see questions
  User can show question
" do
  given!(:questions) { create_list(:uniq_question, 3) }
  scenario 'User can see 3 questions' do
    visit root_path

    p questions

    expect(page.find_all('li.question').count).to eq 3

    questions.each do |question|
      expect(page).to have_content question.title
    end
  end

  scenario 'User can show question' do
    visit question_path(questions.first)

    expect(page).to have_content questions.first.title
    expect(page).to have_content questions.first.body
  end
end
