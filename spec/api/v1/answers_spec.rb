require 'rails_helper'

describe 'Profile API', type: :request do
  let(:headers)      { { 'CONTENT_TYPE' => 'application/json',
                    'ACCEPT' => 'application/json'} }
  let(:access_token) { create(:access_token) }
  let(:question)     { create(:question, :with_answers) }
  let(:answer)       { question.answers.first }

  describe 'GET /api/v1/questions/:question_id/answers/' do
    let(:api_path) { "/api/v1/questions/#{question.id}/answers/" }

    it_behaves_like 'API Authorizable' do
      let(:method) { :get }
    end

    context 'authorized' do
      let(:answer_response) { json['answers'].first }
      before { get api_path, params: { access_token: access_token.token }, headers: headers }

      it_behaves_like 'API response status 200'

      it 'return list answers' do
        expect(json['answers'].size).to eq 5
      end

      it 'return all public fields' do
        %w[id body question_id created_at updated_at].each do |attr|
          expect(answer_response[attr]).to eq answer.send(attr).as_json
        end
      end
    end
  end

  describe 'GET /api/v1/answers/:id' do
    let(:api_path)         { "/api/v1/answers/#{answer.id}" }
    let(:answer)           { create(:answer, :answer_with_link, :with_file, :with_answer_comment) }
    let(:answer_response)  { json['answer'] }
    let(:link)             { answer.links.first }
    let(:link_response)    { answer_response['links'].first }
    let(:comment)          { answer.comments.first }
    let(:comment_response) { answer_response['comments'].first }

    before { get api_path, params: { access_token: access_token.token }, headers: headers}

    it_behaves_like 'API response status 200'

    it 'return all public fields' do
      %w[id body question_id created_at updated_at].each do |attr|
        expect(answer_response[attr]).to eq answer.send(attr).as_json
      end
    end

    it 'return all public fields for links' do
      %w[id name url linkable_type linkable_id created_at updated_at].each do |attr|
        expect(link_response[attr]).to eq link.send(attr).as_json
      end
    end

    it 'return url for files' do
      expect(answer_response['files'].first).to match 'rails_helper.rb'
    end

    it 'return all public fields for comments' do
      %w[id body created_at updated_at commentable_type commentable_id].each do |attr|
        expect(comment_response[attr]).to eq comment.send(attr).as_json
      end
    end
  end
end
