# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_new_answer, only: :show
  before_action :set_new_links, only: %i[new edit]
  before_action :set_new_reward, only: %i[new edit]
  after_action :publish_question, only: %i[create]

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
    params.require(:question).permit(:title, :body, :author_id, files: [], links_attributes: %i[name url],
                                     reward_attributes: %i[title image])
  end

  def set_new_answer
    @answer = Answer.new
  end

  def set_new_links
    question.links.new
  end

  def set_new_reward
    question.build_reward
  end

  def publish_question
    return if question.errors.any?
    ActionCable.server.broadcast(
      'questions',
      ApplicationController.render( partial: 'questions/question_light', locals: { question: question })
    )
  end
end
