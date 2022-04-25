# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, author: user) }

  before { login(user) }

  describe 'POST #create' do
    # context 'with valid attributes' do
    #   it 'saves a new question in the database' do
    #     expect { post :create, params: { question: attributes_for(:question) } }.to change(Question, :count).by(1)
    #   end
    #
    #   it 'redirects to show view' do
    #     post :create, params: { question: attributes_for(:question), author_id: user }
    #     byebug
    #     expect(response).to redirect_to assigns(:exposed_question)
    #   end
    # end

    context 'with invalid attributes' do
      it 'does not save the question' do
        expect do
          post :create, params: { question: attributes_for(:question, :invalid), author_id: user }
        end.to_not change(Question, :count)
      end

      it 're-renders new view' do
        post :create, params: { question: attributes_for(:question, :invalid), author_id: user }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'assigns the requested question to @question' do
        patch :update, params: { id: question, question: attributes_for(:question), author_id: user }
        expect(assigns(:exposed_question)).to eq question
      end

      it 'changes question attributes' do
        patch :update, params: { id: question, question: { title: 'new title', body: 'new body', author_id: user } }
        question.reload

        expect(question.title).to eq 'new title'
        expect(question.body).to eq 'new body'
      end

      it 'redirects to updated question' do
        patch :update, params: { id: question, question: attributes_for(:question), author_id: user }
        expect(response).to redirect_to question
      end
    end

    context 'with invalid attributes' do
      before { patch :update, params: { id: question, question: { title: '', body: 'new body', author_id: user } } }

      it 'does not change question' do
        question.reload

        expect(question.title).to_not eq ''
        expect(question.body).to_not eq 'new body'
      end

      it 're-renders edit view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'author' do
      let!(:question) { create(:question, author: user) }

      it 'deletes the question' do
        expect { delete :destroy, params: { id: question } }.to change(Question, :count).by(-1)
      end

      it 'redirects to root' do
        delete :destroy, params: { id: question }
        expect(response).to redirect_to questions_path
      end
    end

    context 'not author' do
      let!(:question) { create(:question) }

      it 'deletes the question' do
        expect { delete :destroy, params: { id: question } }.to change(Question, :count).by(0)
      end
    end
  end
end
