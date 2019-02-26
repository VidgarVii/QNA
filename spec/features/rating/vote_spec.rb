require 'rails_helper'

feature 'Authenticated user can vote for the question/answer',"
  User unable vote for own a question/answer
  User can vote particular question/answer only ones
  The user can cancel his decision and then re-vote
  The question/answer should display the resulting rating (the difference between the votes for and against)
" do
  given(:user) { create(:user) }
  given(:question) { create(:question, :with_answers) }

  context 'Authenticated user can to vote the question' do
    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'to raise the rating', js: true do
      within "#question-#{question.id}" do
        find('.fa-caret-up').click

        expect(find('.rating')).to have_content '1'
      end
    end

    scenario 'to lower the rating', js: true do
      within "#question-#{question.id}" do
        find('.fa-caret-down').click

        expect(find('.rating')).to have_content '-1'
      end
    end

    scenario 'UP only ones', js: true do
      within "#question-#{question.id}" do
        find('.fa-caret-up').click
        find('.fa-caret-up').click

        expect(find('.rating')).to have_content '1'
      end
    end

    scenario 'Down only ones', js: true do
      within "#question-#{question.id}" do
        find('.fa-caret-down').click
        find('.fa-caret-down').click

        expect(find('.rating')).to have_content '-1'
      end
    end
  end

  context 'Unauthenticated user unable to vote the question' do
    background do
      visit question_path(question)
    end

    scenario 'error', js: true do
      within "#question-#{question.id}" do
        find('.fa-caret-up').click
      end

      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end

  context 'Authenticated user can to vote the answer' do
    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'to raise the rating', js: true do
      within "#vote-answer-#{question.answers[0].id}" do
        find('.fa-caret-up').click

        expect(find('.rating')).to have_content '1'
      end
    end

    scenario 'to lower the rating', js: true do
      within "#vote-answer-#{question.answers[0].id}" do
        find('.fa-caret-down').click

        expect(find('.rating')).to have_content '-1'
      end
    end

    scenario 'UP only one', js: true do
      within "#vote-answer-#{question.answers[0].id}" do
        find('.fa-caret-up').click
        find('.fa-caret-up').click

        expect(find('.rating')).to have_content '1'
      end
    end

    scenario 'DOWN only one', js: true do
      within "#vote-answer-#{question.answers[0].id}" do
        find('.fa-caret-down').click
        find('.fa-caret-down').click

        expect(find('.rating')).to have_content '-1'
      end
    end
  end

  context 'Unauthenticated user unable to vote the answer' do
    background do
      visit question_path(question)
    end

    scenario 'error', js: true do
      within "#vote-answer-#{question.answers[0].id}" do
        find('.fa-caret-up').click
      end

      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end
end
