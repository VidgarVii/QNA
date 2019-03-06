module FeatureHelpers
  def sign_in(user)
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
  end

  def oath_instagram
    visit new_user_session_path
    click_on 'Sign in with Instagram'
  end
end
