class AnswersChannel < ApplicationCable::Channel
  def follow
    stop_all_streams
    stream_from "publish_answer_for_#{params[:question_id]}"
  end

  def unfollow
    stop_all_streams
  end
end
