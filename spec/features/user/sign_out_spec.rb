require 'rails_helper'

feature 'Authenticated user can logout' do

  given(:user) { create(:user) }

  background { sign_in(user) }

  scenario 'Should see button Exit' do
    expect(page).to have_content 'Exit'
  end

  scenario 'User logout' do
    click_on 'Exit'

    expect(page).to have_content 'Signed out successfully.'
  end
end