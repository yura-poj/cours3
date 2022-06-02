# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_new_answer, only: :show
  before_action :set_new_links, only: %i[new edit]

  expose :questions, -> { Question.with_attached_files.all }
  expose :question, find: ->(id, scope) { scope.with_attached_files.find(id) }
  expose :answers, -> { question.answers.all }

  def create
    respond_to do |format|
      if question.save
        flash.now[:success] = 'Your question successfully created'
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if question.update(question_params)
        flash.now[:success] = 'Your question successfully updated'
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if question.author?(current_user)
        question.destroy
        flash.now[:success] = 'Your question successfully deleted'
        format.turbo_stream
      else
        format.html { redirect_back fallback_location: root_path, status: :unprocessable_entity }
      end
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body, :author_id, files: [], links_attributes: [:name, :url])
  end

  def set_new_answer
    @answer = Answer.new
  end

  def set_new_links
    question.links.new
  end
end
