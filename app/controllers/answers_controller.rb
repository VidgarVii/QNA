class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :question_author!, only: :set_best
  before_action :answer_author!, only: %i[update destroy_attachment destroy]

  def create
    @answer = question.answers.new(answer_params)
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

  def destroy_attachment
    attachment.purge
  end

  private

  helper_method :answer, :question, :attachment

  def question_author!
    head :forbidden unless current_user&.author_of?(answer.question)
  end

  def answer_author!
    head :forbidden unless current_user&.author_of?(answer)
  end

  def attachment
    @attachment ||= ActiveStorage::Attachment.find(params[:file_id])
  end

  def question
    @question ||= params[:question_id] ? Question.find(params[:question_id]) : answer.question
  end

  def answer
    @answer ||= params[:id] ? Answer.with_attached_files.find(params[:id]) : Answer.new
  end

  def answer_params
    params.require(:answer).permit(:body, files: [])
  end
end
