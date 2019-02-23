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
    end

    scenario 'valid image' do
      within '.honor' do
        fill_in 'Name', with: 'Test Honor'
        attach_file 'Image', "#{Rails.root}/spec/fixtures/images/ruby.png"

        expect(page).to have_content 'Test Honor'
        expect(page).to have_xpath 'img'
      end
    end

    scenario 'invalid image' do
      within '.honor' do
        fill_in 'Name', with: 'Test Honor'
        attach_file 'Image', "#{Rails.root}/spec/fixtures/images/big.jpg"

      end
    end
  end
end
