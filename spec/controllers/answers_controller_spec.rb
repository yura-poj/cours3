# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }

  before { login(user) }

  # describe 'POST #create' do
  #   context 'with valid attributes' do
  #     it 'saves a new answer for question in the database' do
  #       expect do
  #         post :create,
  #              params: { answer: attributes_for(:answer), question_id: question, author_id: user }
  #       end.to change(question.answers, :count).by(1)
  #     end
  #
  #     it 'redirects to question show view' do
  #       post :create, params: { answer: attributes_for(:answer), question_id: question, author_id: user }
  #       expect(response).to redirect_to assigns(:answer)
  #     end
  #   end
  #
  #   context 'with invalid attributes' do
  #     it 'does not save the answer of question' do
  #       expect do
  #         post :create,
  #              params: { answer: attributes_for(:answer, :invalid), question_id: question, author_id: user }
  #       end.to_not change(Answer, :count)
  #     end
  #
  #     it 're-renders answer new view ' do
  #       post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question, author_id: user }
  #       expect(response).to render_template :new
  #     end
  #   end
  # end

  describe 'DELETE #destroy' do
    context 'author' do
      let!(:answer) { create(:answer, author: user) }

      it 'deletes the answer' do
        expect { delete :destroy, params: { id: answer } }.to change(Answer, :count).by(-1)
      end
    end

    context 'not author' do
      let!(:answer) { create(:answer) }

      it 'deletes the answer' do
        expect { delete :destroy, params: { id: answer } }.to change(Answer, :count).by(0)
      end
    end
  end
end
