# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:answer) { create(:answer) }
  let(:question) { create(:question) }
  let(:author) { create(:user) }
  let(:user) { create(:user) }

  describe 'POST #create' do
    before { login(author) }

    let(:create_answer) { post :create, params: { answer: attributes_for(:answer), question_id: question.id }, format: :js }

    context 'with valid attributes' do
      it 'saves a new answer in the database' do
        expect { create_answer }.to change(question.answers, :count).by(1)
      end

      it 'redirects to show view question' do
        create_answer

        expect(response).to render_template :create
      end

      it 'Current user is author of a answer' do
        expect { create_answer }.to change(author.answers, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      let(:invalid_answer) { post :create, params: { answer: attributes_for(:answer, :invalid_answer), question_id: question.id }, format: :js }

      it 'does not save the answer' do
        expect { invalid_answer }.to_not change(Answer, :count)
      end

      it 're-render new view' do
        invalid_answer

        expect(response).to render_template :create
      end
    end
  end
end
