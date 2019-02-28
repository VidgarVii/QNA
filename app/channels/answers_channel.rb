class AnswersChannel < ApplicationCable::Channel
  def follow(data)
    stop_all_streams
    stream_from "publish_answer_for-#{data['id']}"
  end

  def unfollow
    stop_all_streams
  end
end
