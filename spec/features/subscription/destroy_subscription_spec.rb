require 'rails_helper'

feature 'Authenticated user can cancel subscription' do
  let(:question) { create(:question) }
  let(:user) { create(:user) }

  scenario 'unsubscribe', js: true do
    user.subscriptions.create!(question: question)

    sign_in(user)
    visit question_path(question)

    within '.subscription' do
      accept_confirm do
        click_on 'Unsubscribe'
      end
      sleep 1
      expect(page).to have_content 'Subscribe to the update issue'
    end
  end
end
