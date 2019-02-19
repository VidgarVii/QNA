require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to(:question).counter_cache(true) }
  it { should belong_to :author }
  it { should validate_presence_of :body }

  describe 'make_the_best' do
    let(:question) {create(:question)}
    let(:answer) { create(:answer, question: question) }
    let!(:best_answer) { create(:answer, question: question, best: true) }

    it 'answer make_the_best' do
      answer.make_the_best
      answer.reload

      expect(answer).to be_best
    end

    it 'after call #make_the_best old best_answer make not best' do
      answer.make_the_best
      best_answer.reload

      expect(best_answer).to_not be_best
    end
  end
end
