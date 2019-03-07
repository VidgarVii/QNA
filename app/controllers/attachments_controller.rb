class AttachmentsController < ApplicationController
  before_action :authenticate_user!

  # authorize_resource class: 'ActiveStorage::Attachment'

  def destroy
    attachment.purge
    authorize! :destroy, attachment
  end

  private

  helper_method :attachment

  def attachment
    @atatchment ||= ActiveStorage::Attachment.find(params[:id])
  end
end
