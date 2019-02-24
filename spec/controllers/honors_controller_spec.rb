require 'rails_helper'

RSpec.describe HonorsController, type: :controller do

  describe 'GET #index' do
    let(:user) { create(:user) }

    before do
      login(user)
      get :index
    end

    it 'render template index' do
      expect(response).to render_template :index
    end
  end
end
