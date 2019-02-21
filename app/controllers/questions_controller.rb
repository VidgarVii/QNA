class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def index
    @questions = Question.all
  end

  def show
    @answers = question.answers.order(best: :desc)
    @answer = Answer.new
    @link = @answer.links.build
  end

  def new
    question.links.build
  end

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
    if current_user&.author_of?(question)
      question.update(question_params)
    else
      head :forbidden
    end
  end

  def destroy
    question.destroy if current_user.author_of?(question)

    redirect_to questions_path
  end

  private

  helper_method :question

  def question
    @question ||= params[:id] ? Question.with_attached_files.find(params[:id]) : Question.new
  end

  def question_params
    params.require(:question).permit(:title, :body, files: [], links_attributes: [:name, :url])
  end
end
