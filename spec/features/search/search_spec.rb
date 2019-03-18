require 'rails_helper'

feature 'User can search question/answer/comment/all', sphinx: true do
  given!(:question) { create(:question, body: 'some text for question') }
  given!(:answer)   { create(:answer,   body: 'some text for answer',  question: question) }
  given!(:comment)  { create(:comment,  body: 'some text for comment', commentable: question) }

  background do
    visit root_path
  end

  scenario 'Search by all models', js: true, sphinx: true do
    ThinkingSphinx::Test.run do
      click_on 'Find'
      p question
      p answer
      p comment

      within '.result-search' do
        expect(page).to have_content 'some text for question'
        expect(page).to have_content 'some text for answer'
        expect(page).to have_content 'some text for comment'
        expect(page).to have_content question.author.email
        expect(page).to have_content answer.author.email
        expect(page).to have_content comment.author.email
      end
    end
  end

  scenario 'Search by question', js: true, sphinx: true do
    ThinkingSphinx::Test.run do
      fill_in 'Search', with: 'question'
      check 'question'
      click_on 'Find'

      sleep 2

      within '.result-search' do
        expect(page).to have_content 'some text for question'
      end
    end
  end

  scenario 'Search by answer', js: true, sphinx: true do
    ThinkingSphinx::Test.run do
      fill_in 'Search', with: 'answer'
      check 'answer'
      click_on 'Find'

      within '.result-search' do
        expect(page).to have_content 'some text for answer'
      end
    end
  end

  scenario 'Search by comment', js: true, sphinx: true do
    ThinkingSphinx::Test.run do
      fill_in 'Search', with: 'comment'
      check 'comment'
      click_on 'Find'

      within '.result-search' do
        expect(page).to have_content 'some text for comment'
      end
    end
  end

  scenario 'No result', js: true, sphinx: true do
    ThinkingSphinx::Test.run do
      fill_in 'Search', with: 'qwerty'
      click_on 'Find'

      expect(page).to_not have_content 'qwerty'
    end
  end
end
