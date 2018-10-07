class Api::V1::UsersController < Api::V1::BaseController

  before_action :authenticate_with_token!, only: [:update]
  before_action :find_user, only: [:show, :update]

  def columns
    exclude_columns = ['auth_token', 'created_at', 'updated_at']
    User.attribute_names.delete_if{|x| exclude_columns.include?(x)}
  end

  def index
    @users = User.select(columns)
    render json: { message: "Consult Correct.", success: true, users: @users }, status: :ok
  end

  def create
    user = User.new(user_params)
    user.password = params[:password]
    user.password_confirmation = params[:password_confirmation]
    return render json: { errors: user.errors, message: "User couldn't be created.", success: false }, status: :unprocessable_entity if !user.save
    response_user = {email: user.email}
    render json: { user: response_user, message: "User created successfully.", success: true }, status: :created
  end

  def update
    return render json: { errors: @user.errors, message: "User couldn't be updated successfully.", success: false }, status: :unprocessable_entity if !@user.update(user_params)
    response_user = {email: @user.email}
    render json: { user: response_user, message: "User updated successfully.", success: true }, status: :ok
  end

  def show
    response_user = {email: @user.email}
    render json: { user: response_user, success: true }, status: :ok
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def find_user
    @user = User.find(params[:id])
  end
end