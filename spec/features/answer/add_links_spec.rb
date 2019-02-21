require 'rails_helper'

feature 'User can add links to answer', "
  In order to provide additional info to my answer
  As an answer author
  I'd like to be able to add links
" do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given(:google_url) { 'https://google.ru' }
  given(:gist_url) { 'https://gist.github.com/VidgarVii/5d57bfba7d270fe169a8189fa5c28575' }

  scenario 'User adds link when asks question', js: true do
    sign_in(user)
    visit question_path(question)

    fill_in 'Body', with: 'Body answer'

    fill_in 'Name', with: 'My gist'
    fill_in 'Url', with: gist_url
    click_on 'add link'

    within '.nested-fields' do
      fill_in 'Name', with: 'google'
      fill_in 'Url', with: google_url
    end

    click_on 'Answer'

    within '.answer' do
      expect(page).to have_link 'My gist', href: gist_url
      expect(page).to have_link 'google', href: google_url
    end
  end
end
