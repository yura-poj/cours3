require 'rails_helper'

describe 'answers API', type: :request do
  let(:headers) {{"CONTENT_TYPE" => "application/json",
                  "ACCEPT" => 'application/json'}}

  describe 'POST /api/v1/question/question_id/answers' do
    let(:question) { create(:question) }
    let(:api_path) { "/api/v1/questions/#{question.id}/answers" }
    let(:user) { create(:user)}

    it_behaves_like 'API Authorizable' do
      let(:method) { :post }
    end

    context 'authorized' do
      let(:access_token) {create(:access_token)}

      it 'returns 422 status' do
        post api_path, params: { access_token: access_token.token, answer: attributes_for(:answer, body: ''), headers: headers }
        expect(response.status).to eq 422
      end

      it 'do not create answer' do
        expect{
          post api_path, params: { access_token: access_token.token, answer: attributes_for(:answer, body: ''), headers: headers }
        }.to change(Answer, :count).by(0)
      end

      it 'returns 201 status' do
        post api_path, params: { access_token: access_token.token, answer: attributes_for(:answer, author_id: user.id), headers: headers }
        expect(response.status).to eq 201
      end

      it 'create answer' do
        expect{
          post api_path, params: { access_token: access_token.token, answer: attributes_for(:answer, author_id: user.id), headers: headers }
        }.to change(Answer, :count).by(1)
      end
    end
  end

  describe 'GET /api/v1/answers/id' do
    let!(:answer) { create(:answer) }
    let!(:links) { create_list(:link, 2, linkable: answer) }
    let!(:api_path) { "/api/v1/answers/#{answer.id}" }

    it_behaves_like 'API Authorizable' do
      let(:method) { :get }
    end

    context 'authorized' do
      let(:access_token) {create(:access_token)}

      before do
        get api_path, params: { access_token: access_token.token }, headers: headers
      end

      it 'returns 200 status' do
        expect(response).to be_successful
      end

      it 'returns list of links' do
        expect(json['answer']['links'].size).to eq 2
      end

      it 'returns all public fields of links' do
        %w[id name url linkable_id].each do |attr|
          expect(json['answer']['links'].first[attr]).to eq links.first.send(attr).as_json
        end
      end

      it 'returns all public fields' do
        %w[id question_id body created_at updated_at].each do |attr|
          expect(json['answer'][attr]).to eq answer.send(attr).as_json
        end
      end

      it 'contains user object' do
        expect(json['answer']['author']['id']).to eq answer.author.id
      end
    end
  end

  describe 'DELETE /api/v1/answers/id' do
    let!(:answer) {create(:answer)}
    let(:api_path) { "/api/v1/answers/#{answer.id}" }

    it_behaves_like 'API Authorizable' do
      let(:method) { :delete }
    end

    context 'authorized' do
      let(:access_token) {create(:access_token)}

      it 'returns 200 status' do
        delete api_path, params: { access_token: access_token.token, headers: headers }
        expect(response.status).to eq 200
      end

      it 'delete answer' do
        expect{
          delete api_path, params: { access_token: access_token.token, headers: headers }
        }.to change(Answer, :count).by(-1)
      end
    end
  end

  describe 'PUT /api/v1/answers/id' do
    let!(:answer) {create(:answer)}
    let(:api_path) { "/api/v1/answers/#{answer.id}" }

    it_behaves_like 'API Authorizable' do
      let(:method) { :put }
    end

    context 'authorized' do
      let(:access_token) {create(:access_token)}

      it 'returns 422 status' do
        put api_path, params: { access_token: access_token.token, answer: { body: ''}, headers: headers }
        expect(response.status).to eq 422
      end

      it 'returns 200 status' do
        put api_path, params: { access_token: access_token.token, answer: { body: '1'}, headers: headers }
        expect(response.status).to eq 200
      end

      it 'update answer' do
        put api_path, params: { access_token: access_token.token, answer: { body: '1'}, headers: headers }
        expect(Answer.find(answer.id).body).to eq '1'
      end
    end
  end

end

