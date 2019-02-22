require 'rails_helper'

describe 'Get gist content' do
  let(:url) { 'https://gist.github.com/VidgarVii/5d57bfba7d270fe169a8189fa5c28575' }
  let(:invalid_url) { 'https://gist.github.com/VidgarVii/2ef468a3d39a0e6717e76dd9918b67e5' }

  describe 'Get response' do
    let(:valid_service) { GistService.new(url) }
    let(:invalid_service) { GistService.new(invalid_url) }

    it 'get response string' do
      expect(valid_service.content.class).to eq String
    end

    it 'status 200' do
      expect(valid_service.status).to eq 200
    end

    it 'invalid link' do
      expect(invalid_service.content).to eq 404
    end

    it 'status 404' do
      expect(invalid_service.status).to eq 404
    end
  end
end
