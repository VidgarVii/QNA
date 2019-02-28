class QuestionsChannel < ApplicationCable::Channel
  def follow
    stream_from 'publish_question'
  end
end
