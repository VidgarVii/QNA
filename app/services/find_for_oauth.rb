class Services::FindForOauth
  attr_reader :auth

  def initialize(auth)
    @auth = auth
  end

  def call
    autherization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
    return autherization.user if autherization

    email = auth.info[:email]
    user = User.find_by(email: email)

    if user
      user.create_authorization(auth)
    else
      password = Devise.friendly_token[0, 20]
      user = User.create(email: email, password: password, password_confirmation: password)
      user.create_authorization(auth) if user.valid?
    end

    user
  end
end
