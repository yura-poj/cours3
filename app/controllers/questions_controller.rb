class QuestionsController < ApplicationController
  before_action :find_questions, only: %i[index]
  before_action :find_question, only: %i[show edit update destroy]

  def index
  end

  def show
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to @question
    else
      render :new
    end
  end

  def edit; end

  def update
    @question.update(question_params)
    if @question.save
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    @question.destroy

    redirect_to questions_path
  end

  private

  def find_questions
    @questions = Question.all
  end

  def find_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
