require 'rails_helper'

describe 'Questions API', type: :request do
  let(:headers)      { { 'CONTENT_TYPE' => 'application/json',
                    'ACCEPT' => 'application/json'} }
  let(:access_token) { create(:access_token) }

  describe 'GET api/v1/questions/' do
    let(:api_path) { '/api/v1/questions/' }

    it_behaves_like 'API Authorizable' do
      let(:method) { :get }
    end

    context 'authorized' do
      let!(:questions)   { create_list(:question, 2) }
      let(:question)          { questions.first }
      let(:question_response) { json['questions'].first }
      let!(:answers)     { create_list(:answer, 3, question: question) }

      before { get api_path, params: { access_token: access_token.token }, headers: headers }

      it_behaves_like 'API response status 200'

      it 'return list of questions' do
        expect(json['questions'].size).to eq 2
      end

      it 'return all public fields' do
        %w[id title body created_at updated_at].each do |attr|
          expect(question_response[attr]).to eq question.send(attr).as_json
        end
      end

      it 'contains user object' do
        expect(question_response['author']['id']).to eq question.user_id
      end

      it 'contains short title' do
        expect(question_response['short_title']).to eq question.title.truncate(7)
      end

      describe 'answer' do
        let(:answer) { answers.first }
        let(:answer_response) { question_response['answers'].first }

        it 'return list of answer' do
          expect(question_response['answers'].size).to eq 3
        end

        it 'return all public fields' do
          %w[id body question_id created_at updated_at].each do |attr|
            expect(answer_response[attr]).to eq answer.send(attr).as_json
          end
        end
      end
    end
  end

  describe 'GET /api/v1/questions/:id/' do
    let(:question)          { create(:question, :with_files, :with_link, :with_comment) }
    let(:api_path)          { "/api/v1/questions/#{question.id}/" }
    let(:question_response) { json['question'] }
    let(:link)              { question.links.first }
    let(:link_response)     { question_response['links'].first }
    let(:comment)           { question.comments.first }
    let(:comment_response)  { question_response['comments'].first }

    before { get api_path, params: { access_token: access_token.token }, headers: headers }

    it_behaves_like 'API response status 200'

    it 'return all public fields' do
      %w[id title body created_at updated_at].each do |attr|
        expect(question_response[attr]).to eq question.send(attr).as_json
      end
    end

    it 'return all public fields for links' do
      %w[id name url linkable_type linkable_id created_at updated_at].each do |attr|
        expect(link_response[attr]).to eq link.send(attr).as_json
      end
    end

    it 'return url for files' do
      expect(question_response['files'].first).to match 'rails_helper.rb'
    end

    it 'return all public fields for comments' do
      %w[id body created_at updated_at commentable_type commentable_id].each do |attr|
        expect(comment_response[attr]).to eq comment.send(attr).as_json
      end
    end
  end

  describe 'POST /api/v1/questions/' do
    let(:api_path) { '/api/v1/questions/' }
    let(:headers)  {{"ACCEPT" => 'application/json'}}

    it_behaves_like 'API Authorizable' do
      let(:method) { :post }
    end

    context 'create question with valid attributes' do
      before { post api_path, params: { access_token: access_token.token,
                                        question: attributes_for(:question) },
                    headers: headers  }

      it_behaves_like 'API response status 200'

      it 'return question public field with valid attribute' do
        %w[id title body created_at updated_at files links comments].each do |attr|
          expect(json['question'].has_key?(attr)).to be_truthy
        end
      end

      it 'add question to db' do
        expect(Question.count).to eq 1
      end
    end

    context 'create question with valid attributes' do
      before { post api_path, params: { access_token: access_token.token,
                                        question: attributes_for(:question, :invalid_question) },
                    headers: headers  }
      it 'return status' do
        expect(response).to be_unprocessable
      end

      it 'return error from title' do
        expect(json.has_key?('title')).to be_truthy
      end
    end
  end
end
