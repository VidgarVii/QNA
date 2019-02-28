class AnswersChannel < ApplicationCable::Channel
  def follow(id)
    stream_from "publish_answer_#{id}"
  end
end
