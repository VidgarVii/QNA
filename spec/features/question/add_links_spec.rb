require 'rails_helper'

feature 'User can add links to question', "
  In order to provide additional info to my question
  As an question author
  I'd like to be able to add links
" do

  given(:user) { create(:user) }
  given(:gist_url) { 'https://gist.github.com/VidgarVii/5d57bfba7d270fe169a8189fa5c28575' }

  scenario 'User adds link when asks question' do
    sign_in(user)
    visit new_question_path

    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'Body question'

    fill_in 'Name', with: 'My gist'
    fill_in 'Url', with: gist_url

    click_on 'Ask'

    expect(page).to have_link 'My gist', href: gist_url
  end
end