require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:answer) { create(:answer) }
  let(:question) { create(:question) }
  let(:author) { create(:user) }
  let(:user) { create(:user) }

  describe 'DELETE #destroy' do
    let!(:answer) { create(:answer, author: author) }
    let(:answer_destroy) { delete :destroy, params: { id: answer }, format: :js }

    context 'Author' do
      before { login(author) }

      it 'destroy answer' do
        expect { answer_destroy }.to change(author.answers, :count).by(-1)
      end

      it 'redirect to questions_path' do
        answer_destroy

        expect(response).to render_template :destroy
      end
    end

    context 'Not the author' do
      before { login(user) }

      it 'destroy answer' do
        expect { answer_destroy }.to_not change(Answer, :count)
      end

      it 'redirect to questions_path' do
        answer_destroy

        expect(response).to render_template :destroy
      end
    end

    context 'Not authenticated user' do
      it 'destroy answer' do
        expect { answer_destroy }.to_not change(Answer, :count)
      end

      it 'render to questions_path' do
        answer_destroy

        expect(response).to have_http_status(401)
      end
    end
  end
end
