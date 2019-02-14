# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:author) { create(:user) }
  let(:user) { create(:user) }
  let(:answer) { create(:answer, author: author) }
  let(:questions) { create(:questions) }
  let(:update_answer) { patch :update, params: { id: answer, answer: attributes_for(:answer, :edit_answer) }, format: :js}

  describe 'PATCH #update' do
    before { login(author) }

    context 'with valid attributes' do
      it 'assign the requested answer to @answer' do
        update_answer

        expect(assigns(:answer)).to eq answer
      end

      it 'changes answer attributes' do
        update_answer
        answer.reload

        expect(answer.body).to eq 'New Body'
      end

      it 're-render to updates answer' do
        update_answer

        expect(response).to render_template :update
      end
    end

    context 'with invalid attributes' do
        before { patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid_answer) }, format: :js }

        it 'does not change questions' do
          answer.reload

          expect(answer.body).to eq 'MyText Answer'
        end

        it 're-render edit view' do
          expect(response).to render_template :update
        end
      end

    context 'foreign answer' do
      before { login(user) }
      it 'don t update answer' do
        update_answer
        answer.reload

        expect(answer.body).to_not eq 'New Body'
      end
    end
  end
end
