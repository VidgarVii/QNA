require 'rails_helper'

feature 'User can update own answer' do
  given(:user) { create(:user) }
  given(:answer) { create(:answer) }

  context 'User can edit own answer' do
    given(:gist_url) { 'https://gist.github.com/VidgarVii/5d57bfba7d270fe169a8189fa5c28575' }

    background do
      sign_in(answer.author)
      visit question_path(answer.question)
      click_on 'Edit'
    end

    scenario 'valid attribute', js: true do
      within '.answer' do
        fill_in 'Body', with: 'Edited answer'
        attach_file 'Files', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
        click_on 'add link'

        within '.nested-fields' do
          fill_in 'Name', with: 'GIST'
          fill_in 'Url', with: gist_url
        end

        click_on 'Save'

        expect(page).to_not have_selector 'textarea'
        expect(page).to_not have_content answer.body
        expect(page).to have_content 'Edited answer'
        expect(page).to have_link 'rails_helper.rb'
        expect(page).to have_link 'spec_helper.rb'
        expect(page).to have_link 'GIST', href: gist_url
      end
    end

    scenario 'invalid attribute', js: true do
      within '.answer' do
        fill_in 'Body', with: ''
        click_on 'Save'

        expect(page).to have_selector 'textarea'
        expect(page).to have_content "Body can't be blank"
      end
    end
  end

  context 'User can remove link during edit answer' do
    given(:answer_with_link) { create(:answer, :answer_with_link) }

    background do
      sign_in(answer_with_link.author)
      visit question_path(answer_with_link.question)
    end

    scenario 'remove link', js: true  do
      within '.answer' do
        click_on 'Edit'
        page.find('label.fas.fa-trash').click
        click_on 'Save'

        expect(page).to_not have_link 'rusrails'
      end
    end
  end

  context 'User can remove files in own answer' do
    given(:question) { create(:question, author: user) }

    background do
      sign_in(user)
      visit question_path(question)
      fill_in 'Body', with: 'Answer Body'
      attach_file 'Files', ["#{Rails.root}/spec/spec_helper.rb"]
      click_on 'Answer'
    end

    scenario 'remove files', js: true do
      within '.answer' do
        click_on 'Edit'
        click_on 'Delete'
        click_on 'Save'

        expect(page).to_not have_link 'spec_helper.rb'
      end
    end
  end

  context 'User can not edit foreign answer' do
    scenario 'Unauthenticated user' do
      visit question_path(answer.question)

      expect(page).to_not have_link 'Edit'
    end

    scenario 'Authenticated user' do
      sign_in(user)
      visit question_path(answer.question)

      within '.answer' do
        expect(page).to_not have_link 'Edit'
      end
    end
  end
end
