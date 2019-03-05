class OauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :omniauth

  def github; end

  def vkontakte; end

  def instagram; end

  private

  def omniauth
    @user = User.find_for_oauth(request.env['omniauth.auth'])

    if @user&.persisted?
      sign_in_and_redirect @user, email: :authentication
      set_flash_message(:notice, :success, kind: action_name.capitalize) if is_navigational_format?
    else
      redirect_to root_path, alert: 'Some error. Please retry registration'
    end
  end

  def after_sign_in_path_for(resource)
    if resource.email_verified?
      super resource
    else
      finish_sign_up_path(resource)
    end
  end
end
