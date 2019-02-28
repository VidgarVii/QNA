class QuestionsController < ApplicationController
  include Rated

  after_action :publish_question, only: :create

  before_action :authenticate_user!, except: %i[index show]

  def index
    @questions = Question.all

    gon.push template: 'questions#index'
  end

  def show
    @answers = question.answers.includes(:links).with_attached_files.order(best: :desc)
    @answer  = Answer.new
    @link    = @answer.links.build

    gon.push template: 'questions#show'
    gon.push question_id: question.id
  end

  def new
    question.links.build
    @honor = question.build_honor
  end

  def create
    @question        = Question.new(question_params)
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

  def publish_question
    return if question.errors.any?

    ActionCable.server.broadcast(
        'publish_question',
        ApplicationController.render(
          partial: 'questions/question',
          locals: { question: question }
        )
    )
  end

  def question
    @question ||= Question.with_attached_files.find_or_initialize_by(id: params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, files: [],
                                     links_attributes: [:id, :name, :url, :_destroy],
                                     honor_attributes: [:name, :image])
  end
end
