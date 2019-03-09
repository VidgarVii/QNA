require 'rails_helper'

describe 'Questions API', type: :request do
  let(:headers) { { 'CONTENT_TYPE' => 'application/json',
                    'ACCEPT' => 'application/json'} }

  describe 'GET api/v1/questions/' do
    context 'unauthorized' do
      it 'return 410 status if there is no access token' do
        get '/api/v1/questions/', headers: headers

        expect(response.status).to eq 401
      end

      it 'return 410 status if access token invalid' do
        get '/api/v1/questions/', params: {access_token: 'asdasdasdasdasdasdasd'}, headers: headers

        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let(:access_token) { create(:access_token) }
      let!(:questions) { create_list(:question, 2) }
      let(:question) { questions.first }
      let(:question_response) { json['questions'].first }
      let!(:answers) { create_list(:answer, 3, question: question) }

      before { get '/api/v1/questions/', params: { access_token: access_token.token }, headers: headers }

      it 'return 200 status' do
        expect(response).to be_successful
      end

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
end