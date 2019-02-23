require 'rails_helper'

feature 'Question author can make Honor', "
  Honor have name and image
  The honor is created during creation of the issue
  Honor is given to the user who gave the best answer
  " do

  context 'Create honor' do
    given(:user) { create(:user) }

    background do
      sign_in(user)
      visit new_question_path

      click_on 'Create Honor'

      within '#honor_form' do
        fill_in 'question_honor_attributes_name', with: 'Test Honor'
      end
    end

    scenario 'have image to create question', js: true do
      within '#honor_form' do
        attach_file 'Add image', "#{Rails.root}/spec/fixtures/images/ruby.png", make_visible: true
      end

      expect(page.find('#honor_image')['src']).to have_content 'blob'
    end

    scenario 'invalid files', js: true do
      within '#honor_form' do
        attach_file 'Add image', "#{Rails.root}/spec/rails_helper.rb", make_visible: true
      end

      click_on 'Ask'

      expect(page).to have_content 'Honor image has an invalid content type'
    end

    scenario 'have honor to page question', js: true do
      fill_in 'Title', with: 'Some Title'
      fill_in 'Body', with: 'Text'

      within '#honor_form' do
        attach_file 'Add image', "#{Rails.root}/spec/fixtures/images/ruby.png", make_visible: true
      end

      click_on 'Ask'
      click_on 'Honor'

      within '.honor_block' do
        expect(page).to have_content 'Test Honor'
        expect(page.find('img')['src']).to have_content 'blob'
      end
    end
  end
end
