module AuthHelper
  def basic_auth(user)
    username = user.username
    password = user.password

    credentials = ActionController::HttpAuthentication::Basic
      .encode_credentials(username, password)

    request.env['HTTP_AUTHORIZATION'] = credentials
  end
end

module AuthRequestHelper
  #
  # pass the @env along with your request, eg:
  #
  # GET '/labels', {}, @env
  #
  def basic_auth(user)
    username = user.username
    password = user.password

    {
      'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic
        .encode_credentials(username, password)
    }
  end
end
