class CommentsController < ApplicationController
  before_action :authenticate_user!
  after_action :publish_answer

  def create
    authorize! :create, Comment

    @comment = commented.comments.new(comment_params)
    @comment.author = current_user
    @comment.save
  end

  private

  def publish_answer
    return if @comment.errors.any?

    ActionCable.server.broadcast(
        "publish_comment_for_#{room_id}",
        @comment
    )
  end

  def room_id
    commented.is_a?(Question) ? commented.id : commented.question.id
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def commented
    klass      = [Question, Answer].detect { |c| params["#{c.name.underscore}_id"]}
    @commented = klass.find(params["#{klass.name.underscore}_id"])
  end
end
