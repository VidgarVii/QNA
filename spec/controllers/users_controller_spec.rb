require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #finish_sign_up' do
    context 'user registration' do
      let!(:user) { User.create(email: 'asd@change.me', password: 'password', password_confirmation: 'password') }

      it 'render template' do
        login(user)
        get :finish_sign_up, params: { id: user }

        expect(response).to render_template finish_sign_up
      end
    end

    context 'user exists' do
      let(:user) { create(:user) }
      it 'redirect to root' do
        login(user)
        get :finish_sign_up, params: { id: user }

        expect(response).to redirect_to root_path
      end
    end
  end
end
