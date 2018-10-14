class Api::V1::SessionsController < Api::V1::BaseController
  before_action :doorkeeper_authorize!
end
