class CommentsController < ApplicationController
  def create
    comment = commented.comments.new(comment_params)
    comment.author = current_user

    if comment.save!
      render json: comment
    else
      render json: comment.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def commented
    klass      = [Question, Answer].detect { |c| params["#{c.name.underscore}_id"]}
    @commented = klass.find(params["#{klass.name.underscore}_id"])
  end
end
