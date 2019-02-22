require 'rails_helper'

feature 'User can edit question' do
  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given(:google_url) { 'https://google.ru' }
  given(:gist_url) { 'https://gist.github.com/VidgarVii/5d57bfba7d270fe169a8189fa5c28575' }

  context 'Own question' do

    background do
      sign_in(question.author)
      visit question_path(question)
      click_on 'Edit question'
    end

    scenario 'valid attributes', js: true do

      within '.question' do
        fill_in 'Title', with: 'New Title'
        fill_in 'Body', with: 'New Body'
        attach_file 'Files', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]

        click_on 'add link'
        within '.nested-fields' do
          fill_in 'Name', with: 'GIST'
          fill_in 'Url', with: gist_url
        end

        click_on 'Save'

        expect(page).to_not have_selector '.edit_question_form'
        expect(page).to_not have_content question.body
        expect(page).to_not have_content question.title
        expect(page).to have_content 'New Title'
        expect(page).to have_content 'New Body'
        expect(page).to have_link 'rails_helper.rb'
        expect(page).to have_link 'spec_helper.rb'
        expect(page).to have_link 'GIST', href: gist_url
      end
    end

    scenario 'invalid attributes', js: true do
      within '.question' do
        fill_in 'Title', with: ''
        fill_in 'Body', with: ''
        click_on 'Save'

        expect(page).to have_content "2 error(s) detected"
        expect(page).to have_content "Title can't be blank"
        expect(page).to have_content "Body can't be blank"
      end
    end
  end

  context 'User can remove link during edit question' do
    given(:question_with_link) { create(:question, :with_link) }

    background do
      sign_in(question_with_link.author)
      visit question_path(question_with_link)
      click_on 'Edit question'
    end

    scenario 'remove link', js: true  do
      page.find('label.fas.fa-trash').click
      click_on 'Save'
      expect(page).to_not have_link 'rusrails'
    end
  end

  context 'remove files in own answer' do
    given(:question) { create(:question, :with_files) }

    background do
      sign_in(question.author)
      visit question_path(question)
      click_on 'Edit question'
    end

    scenario 'remove files', js: true do
      within '.edit_question_form' do
        click_on 'Delete'
        click_on 'Save'
        sleep 2
      end

      expect(page).to_not have_link 'rails_helper.rb'
    end
  end

  context 'Foreign question' do
    scenario 'authenticated user' do
      sign_in(user)
      visit question_path(question)

      expect(page).to_not have_content 'Edit Question'
    end

    scenario 'unauthenticated user' do
      visit question_path(question)

      expect(page).to_not have_content 'Edit Question'
    end
  end
end