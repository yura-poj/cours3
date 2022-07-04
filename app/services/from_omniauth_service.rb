class FromOmniauthService
  attr_reader :auth

  def initialize(auth)
    @auth = auth
  end

  def call
    authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
    if authorization
      update_info(authorization.user)
      return authorization.user
    end

    email = auth.info[:email]
    user = User.where(email: email).first
    unless user
      password = Devise.friendly_token[0, 20]
      user = User.create!(email: email, password: password, password_confirmation: password)
    end
    user.authorizations.create(provider: auth.provider, uid: auth.uid)
    update_info(user)

    user
  end

  def update_info(user)
    user.name = auth.info[:name]
    user.image_url = auth.info[:image]
    user.save!
  end
end
