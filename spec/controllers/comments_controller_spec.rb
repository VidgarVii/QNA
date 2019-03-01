require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:question) { create(:question) }
  let(:comment) { create(:comment) }
  let(:user) { create(:user) }
  let(:create_comment) { post :create, params: { comment: attributes_for(:comment),
                                                 question_id: question.id,
                                                 user_id: user.id }, format: :js }

  describe 'POST #create' do
    before { login(user) }

    it 'render template create' do
      create_comment

      expect(response).to render_template :create
    end

    it 'saves a new comments in the database' do
      expect { create_comment }.to change(Comment, :count).by(1)
    end

    it 'with invalid attribute' do
      expect { post :create, params: { comment: {body: ''}, question_id: question.id, user_id: user.id }, format: :js }.to_not change(Comment, :count)
    end
  end
end
