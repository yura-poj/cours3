# frozen_string_literal: true

module Api
  module V1
    class QuestionsController < Api::V1::BaseController
      # after_action :publish_question, only: :create

      def index
        @questions = Question.all
        render json: @questions, each_serializer: QuestionsSerializer
      end

      def create
        @question = Question.create(question_params)
        if @question.persisted?
          head :created
        else
          head :unprocessable_entity
        end
      end

      def update
        if question.update(question_params)
          head :ok
        else
          head :unprocessable_entity
        end
      end

      def show
        render json: question
      end

      def destroy
        question.destroy
        head :ok
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
  end
end
