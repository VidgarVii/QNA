class CommentsChannel < ApplicationCable::Channel
  def follow
    stop_all_streams
    stream_from "publish_comment_for_#{params[:id]}"
  end

  def unfollow
    stop_all_streams
  end
end