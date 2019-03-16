require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should have_one(:honor).dependent(:destroy) }
  it { should have_one(:rating).dependent(:destroy) }
  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:links).dependent(:destroy) }
  it { should have_many(:subscriptions).dependent(:destroy) }
  it { should belong_to :author }

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }

  it { should accept_nested_attributes_for :links }
  it { should accept_nested_attributes_for :honor }

  it 'have many attached files' do
    expect(Question.new.files). to be_an_instance_of(ActiveStorage::Attached::Many)
  end

  it_behaves_like "ratings", :question
  it_behaves_like 'sphinx', Question

  describe 'create subscribed after create question' do
    let(:question) { build(:question) }

    it 'subscribed author' do
      expect { question.save! }.to change(Subscription, :count).by(1)
    end
  end
end

