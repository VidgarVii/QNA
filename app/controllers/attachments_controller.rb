class AttachmentsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    authorize attachment, policy_class: AttachmentPolicy

    attachment.purge
  end

  private

  helper_method :attachment

  def attachment
    @atatchment ||= ActiveStorage::Attachment.find(params[:id])
  end
end
