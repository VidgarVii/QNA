require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #finish_sign_up' do
    context 'user registration' do
      let(:user) { create(:user, email: 'aghjghjsd@change.me') }

      it 'render template' do
        get :finish_sign_up, params: { id: user }

        expect(response).to render_template :finish_sign_up
      end

      it 're render template without new email' do
        patch :finish_sign_up, params: { id: user }

        expect(response).to render_template :finish_sign_up
      end

      it 'confirm new email' do
        patch :finish_sign_up, params: { id: user, user: { email: 'newemail@gmail.com' } }
        sleep 1
        user.reload
        user.confirm

        expect(user.email).to eq 'newemail@gmail.com'
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
