require 'rails_helper'

RSpec.shared_examples 'ratings_controller' do |target|

  let(:user) { create(:user) }
  let(:model) { create(target) }

  describe 'PATCH #rating_up' do
    let(:rating_up) { patch :rating_up, params: { id: model }, format: :json }

    it 'by success' do
      login(user)
      rating_up

      expect(response).to be_successful
    end

    it 'by error' do
      login(model.author)
      rating_up

      expect(response).to have_http_status(:forbidden)
    end
  end

  describe 'PATCH #rating_down' do

    let(:rating_down) { patch :rating_down, params: { id: model }, format: :json }

    it 'by success' do
      login(user)
      rating_down

      expect(response).to be_successful
    end

    it 'by error' do
      login(model.author)
      rating_down

      expect(response).to have_http_status(:forbidden)
    end
  end
end
