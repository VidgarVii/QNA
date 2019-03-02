require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many :questions }
  it { should have_many :answers }
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many :honors }
  it { should have_many(:votes).dependent(:destroy) }

  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  context 'Check #author_of?',
          'Ask question & answer' do
    let(:author) { create(:user) }
    let(:user)   { create(:user) }

    let(:answer)   { create(:answer, author: author) }
    let(:question) { create(:question, author: author) }

    it 'Check authorship' do
      expect(author).to be_author_of(answer)
    end

    it 'Check foreign authorship' do
      expect(user).to_not be_author_of(answer)
    end
  end

  context 'Right for vote' do
    let(:user) { create(:user) }
    let(:question) { create(:question) }

    it 'has_right_up_rate?' do
      expect(user.has_right_up_rate?(question.rating)).to be_truthy
    end

    it 'has_right_down_rate?' do
      expect(user.has_right_down_rate?(question.rating)).to be_truthy
    end
  end

  context 'No Right for vote' do
    let(:user) { create(:user) }
    let(:question) { create(:question) }
    let!(:vote) { create(:vote, user: user, rating: question.rating, state: 1) }

    it 'has_right_up_rate?' do
      expect(user.has_right_up_rate?(question.rating)).to be_falsey
    end

    it 'has_right_down_rate?' do
      vote.update(state: -1)

      expect(user.has_right_down_rate?(question.rating)).to be_falsey
    end
  end
end
