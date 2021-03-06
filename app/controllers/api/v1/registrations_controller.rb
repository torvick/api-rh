class Api::V1::RegistrationsController < Api::V1::BaseController
  before_action :find_registration, only: [:show, :update]

  def columns
    exclude_columns = ['created_at', 'updated_at']
    Registration.attribute_names.delete_if{|x| exclude_columns.include?(x)}
  end

  def index
    authorize Registration
    if current_resource_owner.admin? and !params[:employee_id].nil?
      @registrations = Registration.where(user_id: params[:employee_id]).select(columns)
    else
      @registrations = Registration.all.select(columns) if current_resource_owner.admin?
      @registrations = Registration.where(user_id: current_resource_owner.id) if current_resource_owner.employee?
    end
    render json: { message: "Consult Correct.", success: true, registrations: @registrations.as_json(include: [:user] )}, status: :ok
  end

  def create
    authorize Registration
    registration = Registration.new(registration_params)
    return render json: { errors: registration.errors, message: "registration couldn't be created.", success: false }, status: :unprocessable_entity if !registration.save
    render json: { registration: registration, message: "registration created successfully.", success: true }, status: :created
  end

  def update
    authorize Registration
    return render json: { errors: @registration.errors, message: "registration couldn't be updated successfully.", success: false }, status: :unprocessable_entity if !@registration.update(registration_params)
    render json: { registration: @registration, message: "registration updated successfully.", success: true }, status: :ok
  end

  def show
    authorize Registration
    render json: { registration: @registration, success: true }, status: :ok
  end

  private

  def registration_params
    params.require(:registration).permit(:check_in, :check_out, :user_id )
  end

  def find_registration
    @registration = Registration.find(params[:id])
  end
end
