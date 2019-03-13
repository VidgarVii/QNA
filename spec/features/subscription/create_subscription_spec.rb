require 'rails_helper'

feature 'Authenticated user can subscribe to the question', "
  To receive email notifications when a question is changed or answered
" do
  let(:user) { create(:user) }
  let(:question) { create(:question) }

  scenario 'Unauthenticated unable subscribe' do
    visit question_path(question)
    expect(page).to_not have_content 'Subscribe to the update issue'
  end

  scenario 'Authenticated user subscribe', js: true do
    sign_in(user)
    visit question_path(question)

    within '.subscription' do
      click_on 'Subscribe to the update issue'
      sleep 1
      expect(page).to_not have_content 'Subscribe to the update issue'
      expect(page).to have_content 'You are subscribed to notifications about this issue'
      expect(page).to have_content 'Unsubscribe'
    end
  end
end
