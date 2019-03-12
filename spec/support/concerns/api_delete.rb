shared_examples 'API delete resource' do |target|
  context 'unable destroy foreign question' do
    let(:action) { delete api_path, params: { access_token: access_token.token }, headers: headers  }

    it 'destroy question' do
      expect { action }.to_not change(target, :count)
    end

    it 'return status' do
      action

      expect(response).to be_forbidden
    end
  end

  context 'unable destroy own question' do
    let(:action) { delete api_path, params: { access_token: author_access_token.token }, headers: headers  }

    it 'destroy question' do
      expect { action }.to change(target, :count).by(-1)
    end

    it 'return status' do
      action

      expect(response).to be_successful
    end
  end
end