require 'rails_helper'

feature 'User can see question answers' do
  given(:question) { create(:question, :with_answers, count_answers: 3) }

  before { visit question_path(question) }
  scenario 'User see question and 3 answers' do
    expect(page).to have_content question.answers.first.body
    expect(page.find_all('li.answer').count).to eq 3
  end
end
