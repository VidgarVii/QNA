class AnswersChannel < ApplicationCable::Channel
  def subscribed(id)
    stream_from "publish_answer_#{id}"
  end
end
