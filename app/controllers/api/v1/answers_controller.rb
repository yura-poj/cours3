# frozen_string_literal: true

module Api
  module V1
    class AnswersController < Api::V1::BaseController
      # after_action :publish_answer, only: :create

      def create
        @answer = question.answers.new(answer_params)
        if @answer.save
          head :created
        else
          head :unprocessable_entity
        end
      end

      def update
        if answer.update(answer_params)
          head :ok
        else
          head :unprocessable_entity
        end
      end

      def show
        render json: answer
      end

      def destroy
        answer.destroy
        head :ok
      end

      private

      def answer
        @answer = Answer.find(params[:id])
      end

      def answer_params
        params.require(:answer).permit(:title, :body, :author_id)
      end

      def question
        @question = Question.find(params[:question_id])
      end

      # def publish_answer
      #   return if @answer.persisted?
      #
      #   ActionCable.server.broadcast(
      #     'answers',
      #     ApplicationController.render(partial: 'answers/answer_light', locals: { answer: @answer })
      #   )
      # end
    end
  end
end
