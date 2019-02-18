require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, :with_answers) }
  let(:choose_best_answer) { post :best_answer, params: { id: question, answer_id: question.answers.last.id }, format: :js }

  describe 'PATCH #best_answer', "
  Only author question can choose best answer" do

    it 'set best answer for foreign question' do
      login(user)
      choose_best_answer
      question.reload

      expect(question.best_answer_id).to be_nil
    end

    before { login(question.author) }

    it 'set best answer for question' do
      choose_best_answer
      question.reload

      expect(question.best_answer_id).to eq question.answers.last.id
    end

    it 'render template best_answer' do
      choose_best_answer

      expect(response).to render_template :best_answer
    end
  end
end
