# frozen_string_literal: true

class QuestionChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'questions'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
