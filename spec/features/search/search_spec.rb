require 'rails_helper'

feature 'User can search question/answer/comment/all' do
  let!(:question) { create(:question, body: 'some text for question') }
  let!(:answer) { create(:answer, body: 'some text for answer') }
  let!(:comment) { create(:question, body: 'some text for comment') }

  scenario 'Search by all models', js: true do
    within '.search' do
      fill_in 'Search', with 'some text'
      click_on 'Find'
    end

    within '.result-search' do
      expect(page).to have_content 'some text for question'
      expect(page).to have_content 'some text for answer'
      expect(page).to have_content 'some text for comment'
    end
  end

  scenario 'Search by question', js: true do
    within '.search' do
      fill_in 'Search', with 'question'
      check 'question'
      click_on 'Find'
    end

    within '.result-search' do
      expect(page).to have_content 'some text for question'
    end
  end

  scenario 'Search by answer', js: true do
    within '.search' do
      fill_in 'Search', with 'answer'
      check 'answer'
      click_on 'Find'
    end

    within '.result-search' do
      expect(page).to have_content 'some text for answer'
    end
  end

  scenario 'Search by comment', js: true do
    within '.search' do
      fill_in 'Search', with 'comment'
      check 'comment'
      click_on 'Find'
    end

    within '.result-search' do
      expect(page).to have_content 'some text for comment'
    end
  end
end