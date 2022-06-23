class QuestionChannel < ApplicationCable::Channel
  def subscribed
    puts('a')
    stream_from "questions"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
