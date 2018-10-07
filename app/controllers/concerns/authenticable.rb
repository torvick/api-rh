module Authenticable
  extend ActiveSupport::Concern

  included do
    include ActionController::HttpAuthentication::Token::ControllerMethods
  end

  def current_api_user
    authenticate_with_http_token do |token, options|
      @current_api_user ||= User.find_by(auth_token: token)
    end
  end

  def user_signed_in?
    current_api_user.present?
  end

  def authenticate_with_token!
    current_api_user || render_unauthorized
  end

  def render_unauthorized
    self.headers['WWW-Authenticate'] = 'Token realm="Application"'
    render json: {success: false, message:'Bad Credentials'}, status: :unauthorized
  end
end
