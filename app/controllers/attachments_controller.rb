class AttachmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :author!

  def destroy
    attachment.purge
  end

  private

  helper_method :attachment

  def author!
    head :forbidden unless current_user&.author_of?(attachment.record)
  end

  def attachment
    @atatchment ||= ActiveStorage::Attachment.find(params[:id])
  end
end
