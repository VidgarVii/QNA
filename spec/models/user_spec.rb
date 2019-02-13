require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should have_many :questions }
  it { should have_many :answers }

  context 'Check #author_of?',
          'Ask question & answer' do
    let(:author) { create(:user) }
    let(:user) { create(:user) }

    let(:answer) { create(:answer, author: author) }
    let(:question) { create(:question, author: author) }

    it 'Check authorship' do
      expect(author.author_of?(answer)).to be_truthy
      expect(author.author_of?(question)).to be_truthy
    end

    it 'Check foreign authorship' do
      expect(user.author_of?(answer)).to be_falsey
      expect(user.author_of?(question)).to be_falsey
    end
  end
end
