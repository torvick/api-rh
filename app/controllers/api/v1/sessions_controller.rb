class Api::V1::SessionsController < Api::V1::BaseController

  # before_action :authenticate_with_token!, only: :destroy

  def create
    user = AuthenticateUserService.authenticate(params)
    if user
      render json: { user: user, message: "Signed in successfully.", success: true } , status: :ok
    else
      render json: { message: "Invalid combination of credentials.", success: false }, status: :unprocessable_entity
    end
  end

  def destroy
    user = @current_api_user
    user.auth_token = user.generate_auth_token
    user.save
    head :no_content
  end
end
