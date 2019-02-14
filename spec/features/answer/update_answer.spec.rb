require 'rails_helper'

feature 'User can update own answer' do
  given(:author) { create(:answer) }
  given(:question) { create(:question) }

  context 'User update own answer valid attribute'
  context 'User update own answer invalid attribute'
  context 'User update foreign answer'

end