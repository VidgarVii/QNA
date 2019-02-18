# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:author) { create(:user) }
  let(:question) { create(:question, author: author) }
  let(:answer) { create(:answer, author: author, question: question) }
  let(:user) { create(:user) }
  let(:create_answer) { post :create, params: { answer: attributes_for(:answer), question_id: question.id }, format: :js }
  let(:update_answer) { patch :update, params: { id: answer, answer: attributes_for(:answer, :edit_answer) }, format: :js}
  let(:make_the_best) { patch :set_best, params: { id: answer }, format: :js}

  describe 'POST #create' do

    before { login(author) }

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

  describe 'PATCH #set_best' do

    describe 'make answer the best' do
      before { login(author) }

      it 'for own question' do
        make_the_best
        answer.reload

        expect(answer.best).to be_truthy
      end

      it 're-render template set_best' do
        make_the_best

        expect(response).to render_template :set_best
      end
    end

    describe 'Dont make best answer' do
      it ' for unauthenticated user' do
        make_the_best
        answer.reload

        expect(answer.best).to be_falsey
      end

      it 'dont make best answer for foreign question' do
        login(user)
        make_the_best
        answer.reload

        expect(answer.best).to be_falsey
      end
    end
  end
end
