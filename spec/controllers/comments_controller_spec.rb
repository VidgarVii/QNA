require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:question) { create(:question) }
  let(:comment) { create(:comment) }
  let(:user) { create(:user) }

  describe 'POST #create' do
    before { login(user) }

    it 'with valid attribute' do
      post :create, params: { comment: attributes_for(:comment),
                              question_id: question.id,
                              user_id: user.id }, format: :js

      expect(response).to have_http_status 200
    end

    it 'with invalid attribute' do
      post :create, params: { comment: {body: ''}, question_id: question.id, user_id: user.id }, format: :js

      expect(response).to have_http_status 403
    end
  end
end