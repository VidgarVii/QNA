class HonorsController < ApplicationController
  before_action :authenticate_user!

  def index; end

  private

  helper_method :honors

  def honors
    current_user.honors
  end
end
