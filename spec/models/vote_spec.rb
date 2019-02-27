require 'rails_helper'

RSpec.describe Vote, type: :model do
 it { should belong_to :user }
 it { should belong_to :rating }
 it { should validate_presence_of :state }
 it { should allow_value(1).for(:state) }
 it { should allow_value(0).for(:state) }
 it { should allow_value(-1).for(:state) }
 it { should_not allow_value(-2).for(:state) }
 it { should_not allow_value(2).for(:state) }

 describe 'update state' do
   let(:user) { create(:user) }
   let(:question) { create(:question) }
   let(:vote) { create(:vote, user: user, rating: question.rating) }

   it 'state_up' do
     vote.state_up

     expect(vote.state).to eq 1
   end

   it 'state_down' do
     vote.state_down

     expect(vote.state).to eq -1
   end
 end
end
