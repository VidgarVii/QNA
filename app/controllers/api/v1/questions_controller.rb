class Api::V1::QuestionsController < Api::V1::BaseController
  before_action :doorkeeper_authorize!

  def index
    questions = Question.all.sort_by_update
    render json: questions, each_serializer: QuestionsSerializer
  end

  def show
    render json: question
  end

  def create
    question = Question.new(question_params)
    question.author = current_resource_owner

    if question.save
      render json: question, status: :created
    else
      render json: question.errors, status: :unprocessable_entity
    end
  end

  private

  def question
    @question ||= Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
