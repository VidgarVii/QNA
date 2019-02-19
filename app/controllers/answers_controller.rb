class AnswersController < ApplicationController
  before_action :authenticate_user!

  def create
    @answer = question.answers.new(answer_params)
    @answer.author = current_user
    @answer.save
  end

  def update
    if current_user&.author_of?(answer)
      answer.update(answer_params)
    else
      head :forbidden
    end
  end

  def destroy
    if current_user&.author_of?(answer)
      answer.destroy
    else
      head :forbidden
    end
  end

  def set_best
    if current_user&.author_of?(answer.question)
      answer.make_the_best
      @answers = answer.question.answers.order(best: :desc)
    else
      head :forbidden
    end
  end

  private

  def question
    @question ||= params[:question_id] ? Question.find(params[:question_id]) : answer.question
  end

  def answer
    @answer ||= params[:id] ? Answer.find(params[:id]) : Answer.new
  end

  helper_method :answer, :question

  def answer_params
    params.require(:answer).permit(:body)
  end
end
