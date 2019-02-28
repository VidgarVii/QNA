class AnswersController < ApplicationController
  include Rated

  after_action :publish_answer, only: :create

  before_action :authenticate_user!
  before_action :question_author!, only: :set_best
  before_action :answer_author!, only: %i[update destroy]

  def create
    @answer        = question.answers.new(answer_params)
    @answer.author = current_user
    @answer.save
  end

  def update
    answer.update(answer_params)
  end

  def destroy
    answer.destroy
  end

  def set_best
    answer.make_the_best

    @answers = answer.question.answers.order(best: :desc)
  end

  private

  helper_method :answer, :question

  def publish_answer
    return if answer.errors.any?

    # ActionCable.server.broadcast(
    #     "publish_answer",
    #     answer
    # )
  end

  def question_author!
    head :forbidden unless current_user&.author_of?(answer.question)
  end

  def answer_author!
    head :forbidden unless current_user&.author_of?(answer)
  end

  def question
    @question ||= params[:question_id] ? Question.find(params[:question_id]) : answer.question
  end

  def answer
    @answer ||= Answer.with_attached_files.find_or_initialize_by(id: params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, files: [], links_attributes: [:id, :name, :url, :_destroy])
  end
end
