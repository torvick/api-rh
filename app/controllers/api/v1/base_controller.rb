class Api::V1::BaseController < ActionController::API
  before_action :doorkeeper_authorize!
  # before_action :current_resource_owner
  respond_to :json

  private

  def current_resource_owner
    User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

  def validate_admin?
    return render status: 401, json: {} if !current_resource_owner.admin?
  end
end
