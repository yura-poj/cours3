class Api::V1::QuestionsController < Api::V1::BaseController
  # after_action :publish_question, only: :create

  def index
    @questions = Question.all
    render json: @questions, each_serializer: QuestionsSerializer
  end

  def create
    @question = Question.create(question_params)
    if @question.persisted?
      head 201
    else
      head 422
    end
  end

  def update
    if question.update(question_params)
      head 200
    else
      head 422
    end
  end

  def show
    render json: question
  end

  def destroy
    question.destroy
    head 200
  end

  private

  def question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, :author_id)
  end

  # def publish_question
  #   return if @question.persisted?
  #
  #   ActionCable.server.broadcast(
  #     'questions',
  #     ApplicationController.render(partial: 'questions/question_light', locals: { question: @question })
  #   )
  # end
end