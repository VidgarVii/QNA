# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:answer) { create(:answer) }
  let(:question) { create(:question) }
  let(:user) { create(:user) }

  before { login(user) }

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves a new answer in the database' do
        expect { post :create, params: { answer: attributes_for(:answer), question_id: question.id } }
          .to change(question.answers, :count).by(1)
      end

      it 'redirects to show view question' do
        post :create, params: { answer: attributes_for(:answer), question_id: question.id }
        expect(response).to redirect_to question
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect { post :create, params: { answer: attributes_for(:answer, :invalid_answer), question_id: question.id } }.to_not change(Answer, :count)
      end

      it 're-render new view' do
        post :create, params: { answer: attributes_for(:answer, :invalid_answer), question_id: question.id }
        expect(response).to redirect_to question
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'assign the requested answer to @answer' do
        patch :update, params: { id: answer, answer: attributes_for(:answer) }
        expect(assigns(:answer)).to eq answer
      end

      it 'changes answer attributes' do
        patch :update, params: { id: answer, answer: attributes_for(:answer, :edit_answer) }
        answer.reload

        expect(answer.body).to eq 'New Body'
      end

      it 'redirects to updates answer' do
        patch :update, params: { id: answer, answer: attributes_for(:answer) }
        expect(response).to redirect_to answer
      end
    end

    context 'with invalid attributes' do
      before { patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid_answer) } }

      it 'does not change question' do
        answer.reload

        expect(answer.body).to eq 'MyText'
      end

      it 're-render edit view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:answer) { create(:answer) }
    before { login(user) }

    it 'destroy answer' do
      expect { delete :destroy, params: { id: answer } }.to change(Answer, :count).by(-1)
    end

    it 'redirect to questions_path' do
      delete :destroy, params: { id: answer }
      expect(response).to redirect_to question_path(answer.question)
    end
  end
end
