module AuthHelper
  def basic_auth(user)
    username = user.username
    password = user.password

    credentials = ActionController::HttpAuthentication::Basic
      .encode_credentials(username, password)

    request.env['HTTP_AUTHORIZATION'] = credentials
  end
end
