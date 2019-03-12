require 'rails_helper'

feature 'Authenticated user can subscribed to the question', "
  To receive email notifications when a question is changed or answered
" do
  let(:user) { create(:user) }
  let(:question) { create(:question) }

  background { visit question_path(question) }

  scenario 'Unauthenticated unable described' do
    expect(page).to_not have_content 'Described to the update issue'
  end

  scenario 'Authenticated user described', js: true do
    sign_in(user)

    click_on 'Described to the update issue'
    sleep 1
    expect(page).to_not have_content 'Described to the update issue'
    expect(page).to have_content 'You are subscribed to notifications about this issue'
    expect(page).to have_content 'Unsubscribe'
  end
end
