shared_examples 'API Authorizable' do
  context 'unauthorized' do
    it 'return 410 status if there is no access token' do
      do_request(method, api_path, headers: headers)

      expect(response.status).to eq 401
    end

    it 'return 410 status if access token invalid' do
      do_request(method, api_path, params: {access_token: 'asdasdasdasdasdasdasd'}, headers: headers)

      expect(response.status).to eq 401
    end
  end
end
