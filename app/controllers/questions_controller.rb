class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def index
    @questions = Question.all
  end

  def show; end

  def new; end

  def create
    @question = Question.new(question_params)
    @question.author = current_user

    if @question.save
      redirect_to @question, notice: 'Your question successfully create.'
    else
      render :new
    end
  end

  def update
    current_user.author_of?(question) ? question.update(question_params) : question
  end

  def destroy
    question.destroy if current_user.author_of?(question)

    redirect_to questions_path
  end

  def best_answer
    if current_user.author_of?(question)
      question.update(best_answer: params[:question][:answer_id])
    else
      question
    end
  end

  private

  def question
    @question ||= params[:id] ? Question.find(params[:id]) : Question.new
  end

  helper_method :question

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
