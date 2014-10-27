class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::ImplicitRender

  self.responder = ActionController::Responder
  respond_to :json

  def current_user
    unless @current_user
      authenticate_or_request_with_http_basic do |username, password|
        user = User.find_by(username: username)
        @current_user = user.try(:authenticate, password)
      end
    end
    @current_user
  end
end
