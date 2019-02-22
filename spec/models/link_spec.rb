require 'rails_helper'

RSpec.describe Link, type: :model do
  it { should belong_to :linkable }
  it { should validate_presence_of :name }
  it { should validate_presence_of :url }
  it { should allow_value('http://asd.ru').for :url }
  it { should_not allow_value('asd.ru').for :url }

  context 'check link to the gist' do

    let(:question) { create(:question) }
    let(:link) { create(:link, :gist, linkable: question) }

    it 'gist?' do
      expect(link).to be_gist
    end
  end
end
