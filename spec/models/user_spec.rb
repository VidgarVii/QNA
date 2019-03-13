require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many :questions }
  it { should have_many(:authorizations).dependent(:destroy) }
  it { should have_many :answers }
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many :honors }
  it { should have_many(:votes).dependent(:destroy) }
  it { should have_many(:subscriptions).dependent(:destroy) }

  it { should_not allow_value('asd@change.me').for(:email).on(:update) }
  it { should validate_presence_of :password }
  it { should validate_presence_of :password }

  describe '#author_of?',
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

  describe 'Right for vote' do
    context 'has right' do
      let(:user) { create(:user) }
      let(:question) { create(:question) }

      it 'has_right_up_rate?' do
        expect(user.has_right_up_rate?(question.rating)).to be_truthy
      end

      it 'has_right_down_rate?' do
        expect(user.has_right_down_rate?(question.rating)).to be_truthy
      end
    end

    context 'no Right' do
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

  describe '.find_for_ouath' do
    let!(:user) { create(:user) }
    let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456') }
    let(:service) { double('Services::FindForOauth') }

    it 'calls Services::FindForOauth' do
      expect(Services::FindForOauth).to receive(:new).with(auth).and_return(service)
      expect(service).to receive(:call)
      User.find_for_oauth(auth)
    end
  end

  describe '#email_verified?' do
    let(:user_invalid) { create(:user, email: 'qwer@change.me') }
    let(:user_valid) { create(:user, email: 'qwer@mail.me') }

    it 'false' do
      expect(user_invalid.email_verified?).to be_falsey
    end

    it 'true' do
      expect(user_valid.email_verified?).to be_truthy
    end
  end

  describe '#subscribed_to?' do
    let(:user)     { create(:user) }
    let(:question) { create(:question) }

    it 'false' do
      expect(user.subscribed_to?(question)).to be_falsey
    end

    it 'true' do
      user.subscriptions.create!(question: question)

      expect(user.subscribed_to?(question)).to be_truthy
    end

  end
end
