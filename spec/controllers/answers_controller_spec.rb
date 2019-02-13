# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:answer) { create(:answer) }
  let(:question) { create(:question) }
  let(:author) { create(:user) }
  let(:user) { create(:user) }

  describe 'POST #create' do
    before { login(author) }

    let(:create_answer) { post :create, params: { answer: attributes_for(:answer), question_id: question.id } }

    context 'with valid attributes' do
      it 'saves a new answer in the database' do
        expect { create_answer }.to change(question.answers, :count).by(1)
      end

      it 'redirects to show view question' do
        create_answer

        expect(response).to redirect_to question
      end

      it 'Current user is author of a answer' do
        expect { create_answer }.to change(author.answers, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect { post :create, params: { answer: attributes_for(:answer, :invalid_answer), question_id: question.id } }.to_not change(Answer, :count)
      end

      it 're-render new view' do
        post :create, params: { answer: attributes_for(:answer, :invalid_answer), question_id: question.id }
        expect(response).to render_template :show
      end
    end
  end

  describe 'PATCH #update' do
    before { login(author) }

    let(:update_answer) { patch :update, params: { id: answer, answer: attributes_for(:answer) } }

    context 'with valid attributes' do
      it 'assign the requested answer to @answer' do
        update_answer

        expect(assigns(:answer)).to eq answer
      end

      it 'changes answer attributes' do
        patch :update, params: { id: answer, answer: attributes_for(:answer, :edit_answer) }
        answer.reload

        expect(answer.body).to eq 'New Body'
      end

      it 'redirects to updates answer' do
        update_answer

        expect(response).to redirect_to answer
      end
    end

    context 'with invalid attributes' do
      before { patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid_answer) } }

      it 'does not change question' do
        answer.reload

        expect(answer.body).to eq 'MyText Answer'
      end

      it 're-render edit view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:answer) { create(:answer, author: author) }
    let(:answer_destroy) { delete :destroy, params: { id: answer } }

    context 'Author' do
      before { login(author) }

      it 'destroy answer' do
        expect { answer_destroy }.to change(author.answers, :count).by(-1)
      end

      it 'redirect to questions_path' do
        answer_destroy

        expect(response).to redirect_to question_path(answer.question)
      end
    end

    context 'Not the author' do
      before { login(user) }

      it 'destroy answer' do
        expect { answer_destroy }.to_not change(Answer, :count)
      end

      it 'redirect to questions_path' do
        answer_destroy

        expect(response).to redirect_to question_path(answer.question)
      end
    end

    context 'Not authenticated user' do
      it 'destroy answer' do
        expect { answer_destroy }.to_not change(Answer, :count)
      end

      it 'redirect to questions_path' do
        answer_destroy

        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
