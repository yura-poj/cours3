# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :authenticate_user!

  before_action :question, only: %i[create new]
  before_action :set_new_links, only: %i[new edit]

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

  private

  def question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body, :author_id, files: [], links_attributes: %i[name url])
  end

  def set_new_links
    answer.links.new
  end
end
