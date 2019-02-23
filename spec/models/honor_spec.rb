require 'rails_helper'

RSpec.describe Honor, type: :model do
  it { should belong_to(:question) }
  it { should validate_presence_of :name }
  it { should validate_presence_of :image }
  it { should validate_length_of :image }

  let(:question) { create(:question) }

  it 'have ome attached image' do
    expect(question.build_honor.image). to be_an_instance_of(ActiveStorage::Attached::One)
  end
end
