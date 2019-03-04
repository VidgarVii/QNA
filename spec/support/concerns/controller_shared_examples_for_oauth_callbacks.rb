require 'rails_helper'

RSpec.shared_examples 'oath_callbacks' do |action|

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "GET #{action}" do
    let(:oath_data) { {'provider' => "#{action}", 'uid' => 123} }

    it 'find user from oauth data' do
      allow(request.env).to receive(:[]).and_call_original
      allow(request.env).to receive(:[]).with('omniauth.auth').and_return(oath_data)

      expect(User).to receive(:find_for_oauth)
      get action
    end

    context 'user exists' do
      let(:user) { create(:user) }

      before do
        allow(User).to receive(:find_for_oauth).and_return(user)
        get action
      end

      it 'login user if it exists' do
        expect(subject.current_user).to eq user
      end

      it 'redirects to root path' do
        expect(response).to redirect_to root_path
      end
    end

    context 'user does not exists' do
      before do
        allow(User).to receive(:find_for_oauth)
        get action
      end

      it 'redirects to root path' do
        expect(response).to redirect_to root_path
      end


      it 'does not login user' do
        expect(subject.current_user).to_not be
      end
    end
  end
end
