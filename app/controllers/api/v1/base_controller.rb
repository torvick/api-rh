class Api::V1::BaseController < ActionController::API
  before_action :doorkeeper_authorize!
  before_action :user!
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  respond_to :json

  private

  def user!
    current_user = current_resource_owner
    @current_user = current_user
  end

  def current_resource_owner
    User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

  def user_not_authorized
    return render status: :not_found, json: {success: false, message: 'Not Found'}
  end
end
