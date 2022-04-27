# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_new_answer, only: :show

  expose :questions, -> { Question.all }
  expose :question
  expose :answers, -> { question.answers.all }

  def create
    if question.save
      redirect_to question, notice: 'Your question successfully created.'
    else
      render :new
    end
  end

  def update
    if question.update(question_params)
      redirect_to question
    else
      render :edit
    end
  end

  def destroy
    if question.author?(current_user)
      question.destroy
      redirect_to questions_path
    else
      redirect_back fallback_location: root_path, alert: 'You have not access'
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body, :author_id)
  end

  def set_new_answer
    @answer = Answer.new
  end
end
