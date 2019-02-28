class QuestionsChannel < ApplicationCable::Channel
  def show
    stream_from 'questions_channel'
  end
end
