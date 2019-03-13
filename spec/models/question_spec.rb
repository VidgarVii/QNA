require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should have_one(:honor).dependent(:destroy) }
  it { should have_one(:rating).dependent(:destroy) }
  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:links).dependent(:destroy) }
  it { should have_many(:subscribed).dependent(:destroy) }
  it { should belong_to :author }

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }

  it { should accept_nested_attributes_for :links }
  it { should accept_nested_attributes_for :honor }

  it 'have many attached files' do
    expect(Question.new.files). to be_an_instance_of(ActiveStorage::Attached::Many)
  end

  include_examples "ratings", :question

  describe 'create subscribed after create question' do
    let(:question) { build(:question) }

    it 'subscribed author' do
      expect { question.save! }.to change(Subscription, :count).by(1)
    end
  end

  describe '#notify_subscribers' do
    let(:question) { create(:question) }

    it 'call NotifySubscribersJob' do
      expect(NotifySubscribersJob).to receive(:perform_later).with(question)

      create(:answer, question: question)
    end
  end
end
