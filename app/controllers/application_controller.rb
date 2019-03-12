class ApplicationController < ActionController::Base

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message

    respond_to do |format|
      format.json { head :forbidden, content_type: 'application/json' }
      format.html { redirect_to main_app.root_url, notice: exception.message }
      format.js   { head :forbidden, content_type: 'text/javascript' }
    end
  end

  check_authorization unless :devise_controller?

  private

  def current_ability
    @current_ability ||= Ability.new(current_user || current_resource_owner)
  end
end
