require 'rails_helper'

feature 'Authenticated user can vote for the question/answer',"
  User unable vote for own a question/answer
  User can vote particular question/answer only ones
  The user can cancel his decision and then re-vote
  The question/answer should display the resulting rating (the difference between the votes for and against)
" do
  given(:user) { create(:user) }
  given(:question) { create(:question, :with_answers) }

  context ''

end
