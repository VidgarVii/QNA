require 'rails_helper'

RSpec.shared_examples 'ratings_controller' do |target|

  let(:user) { create(:user) }
  let(:model) { create(target) }

  describe 'PATCH #rating_up' do
    before do
      login(user)

      patch :rating_up, params: { id: model }, format: :json
    end

    it 'by success' do
      expect(response).to be_successful
    end

    it 'by error' do
      expect(response).to have_http_status(:forbidden)
    end
  end

  describe 'PATCH #rating_down' do
    before do
      login(user)

      patch :rating_down, params: { id: model }, format: :json
    end

    it 'by success' do
      expect(response).to be_successful
    end

    it 'by error' do
      expect(response).to have_http_status(:forbidden)
    end
  end
end
