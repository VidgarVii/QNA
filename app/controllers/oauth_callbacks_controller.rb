class OauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :omniauth

  def github; end

  def vkontakte; end

  def instagram; end

  def confirm_email

  end

  private

  def omniauth
    @user = User.find_for_oauth(request.env['omniauth.auth'])

    if @user&.persisted?
      sign_in_and_redirect @user, email: :authentication
      set_flash_message(:notice, :success, kind: action_name.capitalize) if is_navigational_format?
    else
      redirect_to root_path, alert: @user.errors.has_key?('email')
    end
  end
end
