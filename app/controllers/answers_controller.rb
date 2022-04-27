# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :authenticate_user!

  before_action :question, only: %i[create]
  expose :answers, -> { question.answers }
  expose :answer

  def create
    @answer = answers.new(answer_params)
    if @answer.save
      redirect_to @question, notice: 'Successfully created'
      # redirect_to @question, alert: 'Answer is not created', answer: answer
    end
  end

  def destroy
    if answer.author?(current_user)
      answer.destroy
      redirect_back fallback_location: root_path, alert: 'Answer deleted'
    else
      redirect_back fallback_location: root_path, alert: 'You have not access'
    end
  end

  private

  def question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body, :author_id)
  end
end
