class Api::V1::SessionsController < Api::V1::BaseController
  before_action :doorkeeper_authorize!
  # before_action :authenticate_with_token!, only: :destroy
end
