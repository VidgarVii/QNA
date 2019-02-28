class QuestionsChannel < ApplicationCable::Channel
  def follow
    stop_all_streams
    stream_from 'publish_question'
  end

  def unfollow
    stop_all_streams
  end
end
