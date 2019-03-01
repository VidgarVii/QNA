require 'rails_helper'

feature 'User can create answer', "
  In order to get answer from a community
  As an authenticated user
  I'd like to be able to ask the question
" do
  given(:question) { create(:question) }

  context 'Authenticated user' do
    given(:user) { create(:user) }

    background do
      sign_in(user)

      visit question_path(question)
    end

    scenario 'asks a answer', js: true do
      fill_in 'Body', with: 'New Answer!'
      click_on 'Answer'

      expect(page).to have_content 'New Answer!'
    end

    scenario 'asks a answer with errors', js: true do
      click_on 'Answer'

      expect(page).to have_content "Body can't be blank"
      expect(page).to have_content "error(s) detected"
    end

    scenario 'asks an answer with attached files', js: true do
      fill_in 'Body', with: 'Text'
      attach_file 'Files', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
      click_on 'Answer'

      expect(page).to have_link 'rails_helper.rb'
      expect(page).to have_link 'spec_helper.rb'
    end
  end

  scenario 'Unauthenticated user to ask a question' do
    visit question_path(question)
    fill_in 'Body', with: 'New Answer!'
    click_on 'Answer'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  context "mulitple sessions" do
    given(:user) { create(:user) }

    scenario "answer appears on another user's page", js: true do
      using_session('user') do
        sign_in(user)

        visit question_path(question)
      end

      using_session('guest') do
        visit question_path(question)
      end

      using_session('user') do
        fill_in 'Body', with: 'Text'
        attach_file 'Files', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
        click_on 'Answer'

        expect(page).to have_css('.answer', count: 1)
        expect(page).to have_content 'Text'
        expect(page).to have_link 'rails_helper.rb'
        expect(page).to have_link 'spec_helper.rb'
      end

      using_session('guest') do
        expect(page).to have_content 'Text'
        expect(page).to have_link 'rails_helper.rb'
        expect(page).to have_link 'spec_helper.rb'
      end
    end
  end
end
