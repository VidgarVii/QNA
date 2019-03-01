require 'rails_helper'

feature 'Authenticated user can create comments for questions/answers' do
  given(:user) { create(:user) }
  given(:question) { create(:question) }

  context "Create comment in multiple sessions" do
    given(:user) { create(:user) }

    scenario "question appears on another user's page", js: true do
      using_session('user') do
        sign_in(user)

        visit question_path(question)
      end

      using_session('guest') do
        visit question_path(question)
      end

      using_session('user') do
        within '.commentable' do
          click_on 'add a comment'

          fill_in 'Comment', with: 'Some text'
          click_on 'Create Comment'

          sleep 1

          expect(page).to_not have_content 'Comment'
          expect(page).to have_content 'Some text'
        end
      end

      using_session('guest') do
        within '.commentable' do
          expect(page).to have_content 'Some text'
        end
      end
    end
  end

  scenario 'unauthenticated user unable create comments',js: true do
    visit question_path(question)

    click_on 'add a comment'
    fill_in 'Comment', with: 'Some text'
    click_on 'Create Comment'

    expect(page).to_not have_content 'Some text'
  end
end
