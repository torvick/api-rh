class Api::V1::BaseController < ActionController::API
  include Authenticable
  respond_to :json
end
