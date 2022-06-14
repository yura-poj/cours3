# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question) { create(:question) }
  let(:answer) { create(:answer) }
  let(:answers) { create_list(:answer, 2, question: question) }
  let!(:reward) { create(:reward, question: question) }

  it { should have_many :answers }

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }

  describe 'set_best' do
    before do
      question.set_best_answer(answers.first)
    end

    it 'answer need to be best' do
      expect(answers.first.best?).to eq(true)
    end

    it 'should present user reward' do
      expect(reward).to eq(answers.first.author.rewards.first)
    end

    it 'should return previous best answer' do
      expect(question.set_best_answer(answers.second)).to eq(answers.first)
    end

    it 'answer need to be best' do
      question.set_best_answer(answers.second)

      expect(answers.second.best?).to eq(true)
    end

    it 'should not set wrong asnwer' do
      expect(question.set_best_answer(answer)).to eq(nil)
    end
  end
end
