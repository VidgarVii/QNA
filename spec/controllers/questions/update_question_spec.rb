require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question) }
  let(:update_question) { patch :update, params: { id: question, question: attributes_for(:question, :edit_question) }, format: :js }

  describe 'PATCH #update', "
    Author can edit own question
    User unable edit foreign question
  " do

    context 'user unable edit foreign question' do
      before { login(user) }
      before { update_question }

      it 'not change body question' do
        question.reload

        expect(question.title).to eq 'MyString'
        expect(question.body).to eq 'MyText'
      end

      it 'render update question' do
        expect(response).to render_template :update
      end

    end

    before { login(question.author) }

    context 'with valid attributes' do
      it 'assign the requested question to @question' do
        update_question

        expect(assigns(:question)).to eq question
      end

      it 'changes question attributes' do
        update_question
        question.reload

        expect(question.title).to eq 'New Title'
        expect(question.body).to eq 'New Body'
      end

      it 'render update question' do
        update_question

        expect(response).to render_template :update
      end
    end

    context 'with invalid attributes' do
      before { patch :update, params: { id: question, question: attributes_for(:question, :invalid_question) }, format: :js }

      it 'does not change question' do
        question.reload

        expect(question.title).to eq 'MyString'
        expect(question.body).to eq 'MyText'
      end

      it 'render update' do
        expect(response).to render_template :update
      end
    end
  end
end
