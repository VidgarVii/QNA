shared_examples 'API response status 200' do
  it 'return 200 status' do
    expect(response).to be_successful
  end
end
