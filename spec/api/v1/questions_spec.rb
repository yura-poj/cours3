# frozen_string_literal: true

require 'rails_helper'

describe 'Questions API', type: :request do
  let(:headers) do
    { 'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json' }
  end

  describe 'GET /api/v1/questions' do
    let(:api_path) { '/api/v1/questions' }

    it_behaves_like 'API Authorizable' do
      let(:method) { :get }
    end

    context 'authorized' do
      let(:access_token) { create(:access_token) }
      let!(:questions) { create_list(:question, 2) }
      let(:question) { questions.first }
      let(:question_response) { json['questions'].first }
      let!(:answers) { create_list(:answer, 3, question: question) }

      before do
        get api_path, params: { access_token: access_token.token }, headers: headers
      end

      it 'returns 200 status' do
        expect(response).to be_successful
      end

      it 'returns list of questions' do
        expect(json['questions'].size).to eq 2
      end

      it 'returns all public fields' do
        %w[id title body created_at updated_at].each do |attr|
          expect(question_response[attr]).to eq question.send(attr).as_json
        end
      end

      it 'contains user object' do
        expect(question_response['author']['id']).to eq question.author.id
      end

      it 'contains short title' do
        expect(question_response['short_title']).to eq question.title.truncate(7)
      end

      describe 'answers' do
        let(:answer) { answers.first }
        let(:answer_response) { question_response['answers'].first }

        it 'returns list of answers' do
          expect(question_response['answers'].size).to eq 3
        end

        it 'returns all public fields' do
          %w[id body created_at updated_at].each do |attr|
            expect(answer_response[attr]).to eq answer.send(attr).as_json
          end
        end
      end
    end
  end

  describe 'POST /api/v1/questions' do
    let(:api_path) { '/api/v1/questions' }

    it_behaves_like 'API Authorizable' do
      let(:method) { :post }
    end

    context 'authorized' do
      let(:access_token) { create(:access_token) }

      it 'returns 422 status' do
        post api_path,
             params: { access_token: access_token.token, question: attributes_for(:question, title: ''),
                       headers: headers }
        expect(response.status).to eq 422
      end

      it 'do not create question' do
        expect do
          post api_path,
               params: { access_token: access_token.token, question: attributes_for(:question, title: ''),
                         headers: headers }
        end.to change(Question, :count).by(0)
      end

      it 'returns 201 status' do
        post api_path,
             params: { access_token: access_token.token, question: attributes_for(:question), headers: headers }
        expect(response.status).to eq 201
      end

      it 'create question' do
        expect do
          post api_path,
               params: { access_token: access_token.token, question: attributes_for(:question), headers: headers }
        end.to change(Question, :count).by(1)
      end
    end
  end

  describe 'GET /api/v1/questions/id' do
    let!(:question) { create(:question) }
    let!(:links) { create_list(:link, 2, linkable: question) }
    let!(:links) { create_list(:link, 2, linkable: question) }
    let!(:reward) { create(:reward, question: question) }
    let!(:api_path) { "/api/v1/questions/#{question.id}" }

    it_behaves_like 'API Authorizable' do
      let(:method) { :get }
    end

    context 'authorized' do
      let(:access_token) { create(:access_token) }

      before do
        get api_path, params: { access_token: access_token.token }, headers: headers
      end

      it 'returns 200 status' do
        expect(response).to be_successful
      end

      it 'return reward' do
        expect(json['question']['reward']['id']).to eq reward.id
      end

      it 'returns list of links' do
        expect(json['question']['links'].size).to eq 2
      end

      it 'returns all public fields of links' do
        %w[id name url linkable_id].each do |attr|
          expect(json['question']['links'].first[attr]).to eq links.first.send(attr).as_json
        end
      end

      it 'returns all public fields' do
        %w[id title body created_at updated_at].each do |attr|
          expect(json['question'][attr]).to eq question.send(attr).as_json
        end
      end

      it 'contains user object' do
        expect(json['question']['author']['id']).to eq question.author.id
      end
    end
  end

  describe 'DELETE /api/v1/questions/id' do
    let!(:question) { create(:question) }
    let(:api_path) { "/api/v1/questions/#{question.id}" }

    it_behaves_like 'API Authorizable' do
      let(:method) { :delete }
    end

    context 'authorized' do
      let(:access_token) { create(:access_token) }

      it 'returns 200 status' do
        delete api_path, params: { access_token: access_token.token, headers: headers }
        expect(response.status).to eq 200
      end

      it 'delete question' do
        expect do
          delete api_path, params: { access_token: access_token.token, headers: headers }
        end.to change(Question, :count).by(-1)
      end
    end
  end

  describe 'PUT /api/v1/questions/id' do
    let!(:question) { create(:question) }
    let(:api_path) { "/api/v1/questions/#{question.id}" }

    it_behaves_like 'API Authorizable' do
      let(:method) { :put }
    end

    context 'authorized' do
      let(:access_token) { create(:access_token) }

      it 'returns 422 status' do
        put api_path, params: { access_token: access_token.token, question: { title: '' }, headers: headers }
        expect(response.status).to eq 422
      end

      it 'returns 200 status' do
        put api_path, params: { access_token: access_token.token, question: { body: '1' }, headers: headers }
        expect(response.status).to eq 200
      end

      it 'update question' do
        put api_path, params: { access_token: access_token.token, question: { body: '1' }, headers: headers }
        expect(Question.find(question.id).body).to eq '1'
      end
    end
  end
end
