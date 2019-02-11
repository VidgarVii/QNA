class AnswersController < ApplicationController
  before_action :authenticate_user!

  def edit; end

  def create
    @answer = question.answers.new(answer_params)
    @answer.author = current_user
    if @answer.save
      redirect_to question_path(question), notice: 'Your answer successfully create.'
    else
      flash[:alert] = "Body can't be blank!"
      render 'questions/show'
    end
  end

  def update
    if answer.update(answer_params)
      redirect_to answer
    else
      render :edit
    end
  end

  private

  def question
    @question = Question.find(params[:question_id])
  end

  def answer
    @answer ||= params[:id] ? Answer.find(params[:id]) : Answer.new
  end

  helper_method :answer, :question

  def answer_params
    params.require(:answer).permit(:body)
  end
end
