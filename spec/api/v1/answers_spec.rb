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

  describe 'POST /api/v1/answers/' do
    let!(:question) { create(:question) }
    let(:api_path)       { api_v1_question_answers_path(question) }
    let(:headers)        {{"ACCEPT" => 'application/json'}}

    it_behaves_like 'API Authorizable' do
      let(:method) { :post }
    end

    context 'create question with valid attributes' do
      before { post api_path, params: { access_token: access_token.token,
                                        answer: { body: 'Body', question: question, author: question.author } },
                    headers: headers  }

      it_behaves_like 'API response status 200'

      it 'return question public field with valid attribute' do
        %w[id body created_at updated_at files links comments].each do |attr|
          expect(json['answer'].has_key?(attr)).to be_truthy
        end
      end

      it 'add question to db' do
        expect(Answer.count).to eq 1
      end
    end

    context 'create question with valid attributes' do
      before { post api_path, params: { access_token: access_token.token,
                                        answer: attributes_for(:answer, :invalid_answer) },
                    headers: headers  }
      it 'return status' do
        expect(response).to be_unprocessable
      end

      it 'return error from body' do
        expect(json.has_key?('body')).to be_truthy
      end
    end
  end

  describe 'PUT /api/v1/answers/' do
    let!(:answer) { create(:answer) }
    let(:api_path)       { api_v1_answer_path(answer) }
    let(:headers)        { { "ACCEPT" => 'application/json' } }

    it_behaves_like 'API Authorizable' do
      let(:method) { :put }
    end

    context 'create question with valid attributes' do
      before { put api_path, params: { access_token: access_token.token,
                                       answer: { body: 'New answer body' } },
                   headers: headers  }

      it_behaves_like 'API response status 200'

      it 'return question public field with valid attribute' do
        %w[id body created_at updated_at files links comments].each do |attr|
          expect(json['answer'].has_key?(attr)).to be_truthy
        end
      end

      it 'edit question title' do
        expect(json['answer']['body']).to eq 'New answer body'
      end
    end
  end
end
