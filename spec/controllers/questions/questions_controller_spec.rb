require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) { create(:question) }
  let(:user) { create(:user) }
  let(:author) { create(:user) }

  describe 'GET #index' do
    let(:questions) { create_list(:question, 3) }

    before { get :index }

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: question } }

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before { login(author) }
    before { get :new }

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do

    let(:create_question) { post :create, params: { question: attributes_for(:question) } }

    before { login(author) }

    context 'with valid attributes' do
      it 'saves a new question in the database' do
        expect { create_question }.to change(Question, :count).by(1)
      end

      it 'redirects to show view' do
        create_question

        expect(response).to redirect_to assigns(:question)
      end

      it 'Current user is author of a question' do
        expect { create_question }.to change(author.questions, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the question' do
        expect{ post :create, params: { question: attributes_for(:question, :invalid_question) } }.to_not change(Question, :count)
      end

      it 're-render new view' do
        post :create, params: { question: attributes_for(:question, :invalid_question) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #destroy' do
    let!(:question) { create(:question, author: author) }
    let(:question_destroy) { delete :destroy, params: { id: question } }

    context 'Author' do
      before { login(author) }

      it 'delete the question' do
        expect { question_destroy }.to change(author.questions, :count).by(-1)
      end

      it 'redirect to questions_path' do
        question_destroy

        expect(response).to redirect_to questions_path
      end
    end

    context 'Not authenticated user' do
      it 'delete the question' do
        expect { question_destroy }.to_not change(Question, :count)
      end

      it 'redirect to questions_path' do
        question_destroy

        expect(response).to redirect_to  new_user_session_path
      end
    end

    context 'Not the author' do
      before { login(user) }

      it 'delete the question' do
        expect { question_destroy }.to_not change(Question, :count)
      end

      it 'redirect to questions_path' do
        question_destroy

        expect(response).to redirect_to  questions_path
      end
    end
  end
end
