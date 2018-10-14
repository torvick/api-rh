class Api::V1::UsersController < Api::V1::BaseController
  before_action :find_user, only: [:show, :update]

  def columns
    exclude_columns = ['created_at', 'updated_at']
    User.attribute_names.delete_if{|x| exclude_columns.include?(x)}
  end

  def index
    authorize User
    @users = User.all.select(columns) if current_resource_owner.admin?
    @users = User.where(companies_id: params[:companie_id] ).select(columns) if current_resource_owner.admin? and !params[:companie_id].nil?
    @users = [current_resource_owner] if current_resource_owner.employee?
    render json: { message: "Consult Correct.", success: true, users: @users.as_json(include: [:registrations]) }, status: :ok
  end

  def create
    authorize User
    user = User.new(user_params)
    user.password = params[:password]
    user.password_confirmation = params[:password_confirmation]
    return render json: { errors: user.errors, message: "User couldn't be created.", success: false }, status: :unprocessable_entity if !user.save
    render json: { user: user, message: "User created successfully.", success: true }, status: :created
  end

  def update
    authorize User
    return render json: { errors: @user.errors, message: "User couldn't be updated successfully.", success: false }, status: :unprocessable_entity if !@user.update(user_params)
    render json: { user: @user, message: "User updated successfully.", success: true }, status: :ok
  end

  def show
    authorize User
    render json: { user: @user, success: true }, status: :ok
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :phone, :maternal, :paternal, :status, :role, :companies_id, :name, :city, :number_ext, :number_int, :postal_code, :state, :suburb, :address, :rfc )
  end

  def find_user
    @user = User.find(params[:id])
  end
end