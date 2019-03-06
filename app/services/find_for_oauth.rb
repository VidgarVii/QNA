class Services::FindForOauth
  attr_reader :auth

  def initialize(auth)
    @auth = auth
  end

  def call
    autherization = Authorization.find_by(provider: auth.provider, uid: auth.uid.to_s)
    return autherization.user if autherization

    email = auth.info[:email] || make_email
    user = User.find_by(email: email)

    unless user
      user = User.new(email: email, password: make_password, password_confirmation: make_password)
      user.skip_confirmation!
      user.save!
    end

    user.create_authorization(auth)

    user
  end

  private

  def make_password
    @password ||= Devise.friendly_token[0, 20]
  end

  def make_email
    "#{Devise.friendly_token[0, 20]}@change.me"
  end
end
