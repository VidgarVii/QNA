require 'rails_helper'

feature 'Authenticated user can cancel subscription' do
  let(:question) { create(:question) }
  let(:user) { create(:user) }

  scenario 'unsubscribe', js: true do
    user.subscriptions.create!(question: question)

    sign_in(user)
    visit question_path(question)

    click_on 'Unsubscribe'
    sleep 1
    expect(page).to_not have_content 'Described to the update issue'
  end
end
