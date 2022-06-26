# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :authenticate_user!

  before_action :question, only: %i[create new]
  before_action :set_new_links, only: %i[new edit]
  after_action :publish_answers, only: %i[create]

  expose :answers, -> { question.answers }
  expose :answer

  def create
    @answer = answers.new(answer_params)
    respond_to do |format|
      if @answer.save
        flash.now[:success] = 'Your answer successfully created'
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if answer.update(answer_params)
        flash.now[:success] = 'Your answer successfully updated'
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if answer.author?(current_user)
        answer.destroy
        flash.now[:success] = 'Your answer successfully deleted'
        format.turbo_stream
      else
        format.html { redirect_back fallback_location: root_path, status: :unprocessable_entity }
      end
    end
  end

  def set_best
    @previous_answer = answer.question.set_best_answer(answer)
    redirect_to answer.question
    # respond_to do |format|
    #   flash.now[:success] = 'Your link successfully deleted'
    #   format.turbo_stream
    # end
  end

  private

  def question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body, :question_id, :author_id, files: [], links_attributes: %i[name url])
  end

  def set_new_links
    answer.links.new
  end

  def publish_answers
    return if answer.errors.any?

    ActionCable.server.broadcast(
      'answers',
      { body: ApplicationController.render(partial: 'answers/answer_light', locals: { answer: @answer }),
        question: question.id }
    )
  end
end
