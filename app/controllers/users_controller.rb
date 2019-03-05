class UsersController < ApplicationController
  def finish_sign_up
    redirect_to root_path if user.email_verified?

    if request.patch? && params[:user]
      if user.update(user_params)
        render 'users/finish_sign_up', notice: 'A confirmation email has been sent to your email address'
      else
        render 'users/finish_sign_up'
      end
    end
  end

  private

  helper_method :user

  def user_params
    params.require(:user).permit(:email)
  end

  def user
    @user ||= User.find(params[:id])
  end
end
