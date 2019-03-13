class QuestionsController < ApplicationController
  include Rated

  before_action :authenticate_user!, except: %i[index show]

  after_action :publish_question, only: :create

  def index
    authorize! :index, Question

    @questions = Question.all
  end

  def show
    authorize! :show, question

    @answers = question.answers.includes(:links).with_attached_files.order(best: :desc)
    @answer  = Answer.new
    @link    = @answer.links.build

    gon.push question_id: question.id
    gon.push user_id: current_user&.id
  end

  def new
    authorize! :create, Question

    question.links.build
    @honor = question.build_honor
  end

  def create
    authorize! :create, Question

    @question        = Question.new(question_params)
    @question.author = current_user

    if @question.save
      redirect_to @question, notice: 'Your question successfully create.'
    else
      render :new
    end
  end

  def update
    authorize! :update, question

    question.update(question_params)
  end

  def destroy
    authorize! :destroy, question

    question.destroy

    redirect_to questions_path
  end

  private

  helper_method :question, :subscription

  def subscription
    @subscription ||= Subscription.find_by(question: question, user: current_user)
  end

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
