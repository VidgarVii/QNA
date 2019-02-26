require 'rails_helper'

RSpec.shared_examples 'ratings' do |target|

  let(:model) { create(target) }

  it 'should rate' do
    expect(model.rating).to be_an_instance_of(Rating)
  end

  it 'rate up' do
    model.rate_up
    model.reload

    expect(model.rate).to eq 1
  end

  it 'rate down' do
    model.rate_down
    model.reload

    expect(model.rate).to eq -1
  end
end
