require 'rails_helper'

feature 'User can see question & answer' do
  before { create(:question) }

  scenario 'User can see question' do
    visit root_path

    expect(page).to have_content 'MyString'
  end

  scenario 'User can see question answers'
end