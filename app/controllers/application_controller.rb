class ApplicationController < ActionController::Base

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    redirect_back(fallback_location: root_path)
  end

  check_authorization unless: :devise_controller?
end
