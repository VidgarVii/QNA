require 'rails_helper'

RSpec.describe Honor, type: :model do
  it { should belong_to(:user).optional }
  it { should belong_to :question }

  it { should validate_presence_of :name }
  it { should validate_presence_of :image }
  it { should validate_length_of   :image }

  let(:question) { create(:question) }

  it 'have ome attached image' do
    expect(question.build_honor.image). to be_an_instance_of(ActiveStorage::Attached::One)
  end

  describe 'assign honor' do
    let(:honor) { create(:honor) }
    let(:answer) { create(:answer, question: honor.question) }
    let(:answer_2) { create(:answer, question: honor.question) }

    it 'grand' do
      honor.grand(answer.author)
      honor.reload

      expect(honor.user).to eq answer.author
    end
  end
end
