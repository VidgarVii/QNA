class Api::V1::QuestionsController < Api::V1::BaseController
  before_action :doorkeeper_authorize!

  def index
    @questions = Question.all.sort_by_update
    render json: @questions
  end
end
