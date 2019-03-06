class HonorsController < ApplicationController
  before_action :authenticate_user!

  authorize_resource

  def index; end

  private

  helper_method :honors

  def honors
    current_user.honors.with_attached_image.includes(:question)
  end
end
