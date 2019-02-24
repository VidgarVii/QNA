require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many               :questions }
  it { should have_many               :answers }
  it { should have_and_belong_to_many :honors }

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
end
