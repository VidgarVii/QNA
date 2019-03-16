require 'sphinx_helper'

feature 'User can search question/answer/comment/all' do
  given!(:question) { create(:question, body: 'some text for question') }
  given!(:answer) { create(:answer, body: 'some text for answer', question: question) }
  given!(:comment) { create(:comment, body: 'some text for comment', commentable: question) }

  background do
    visit root_path
  end

  scenario 'Search by all models', sphinx: true do
  click_on 'Find'

  within '.result-search' do
      expect(page).to have_content 'some text for question'
      expect(page).to have_content 'some text for answer'
      expect(page).to have_content 'some text for comment'
      expect(page).to have_content 'test1@mail.ru'
    end
  end

  scenario 'Search by question', sphinx: true do
    fill_in 'Search', with: 'question'
    check 'question'
    click_on 'Find'

    within '.result-search' do
      expect(page).to have_content 'some text for question'
    end
  end

  scenario 'Search by answer', sphinx: true do
    fill_in 'Search', with: 'answer'
    check 'answer'
    click_on 'Find'

    within '.result-search' do
      expect(page).to have_content 'some text for answer'
    end
  end

  scenario 'Search by comment', sphinx: true do
    fill_in 'Search', with: 'comment'
    check 'comment'
    click_on 'Find'

    within '.result-search' do
      expect(page).to have_content 'some text for comment'
    end
  end

  scenario 'No result', sphinx: true do
    fill_in 'Search', with: 'qwerty'
    click_on 'Find'

    within '.result-search' do
      expect(page).to_not have_content 'qwerty'
    end
  end
end
