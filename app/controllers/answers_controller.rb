class AnswersController < ApplicationController
  include Rated

  after_action :publish_answer, only: :create

  before_action :authenticate_user!

  def create
    authorize Answer

    @answer        = question.answers.new(answer_params)
    @answer.author = current_user
    @answer.save
  end

  def update
    authorize answer

    answer.update(answer_params)
  end

  def destroy
    authorize answer

    answer.destroy
  end

  def set_best
    authorize answer

    answer.make_the_best

    @answers = answer.question.answers.order(best: :desc)
  end

  private

  helper_method :answer, :question

  def publish_answer
    return if answer.errors.any?

    files = []
    answer.files.each do |file|
      files << { url: url_for(file), name: file.filename.to_s }
    end

    ActionCable.server.broadcast(
        "publish_answer_for_#{answer.question_id}",
        { answer: answer,
          links: answer.links,
          files: files,
          author: answer.author.email }
    )
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
