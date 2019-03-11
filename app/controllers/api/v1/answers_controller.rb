class Api::V1::AnswersController < Api::V1::BaseController
  before_action :doorkeeper_authorize!

  def index
    render json: answers, each_serializer: AnswersSerializer
  end

  def show
    render json: Answer.find(params[:id])
  end

  private

  def answers
    Question.find(params[:question_id]).answers
  end
end
