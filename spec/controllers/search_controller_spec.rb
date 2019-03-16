require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  let!(:question) { create(:question, body: 'some text for question') }
  let!(:answer) { create(:answer, body: 'some text for answer') }
  let!(:comment) { create(:question, body: 'some text for comment') }

  describe 'GET #search' do
    before { get :search, params: { q: 'text', answer: 1 } }

    it 'render template' do
      expect(response).to render_template :search
    end

    it 'assign @result' do
      expect(assigns(:result)).to be_kind_of(ThinkingSphinx::Search)
    end
  end
end
