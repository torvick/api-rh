class Api::V1::CompaniesController < Api::V1::BaseController
  before_action :find_company, only: [:show, :update]

  def columns
    exclude_columns = ['created_at', 'updated_at']
    Company.attribute_names.delete_if{|x| exclude_columns.include?(x)}
  end

  def index
    authorize Company
    @companies = Company.where(id: current_resource_owner.companies_id).select(columns) if current_resource_owner.admin?
    render json: { message: "Consult Correct.", success: true, companies: @companies }, status: :ok
  end

  def create
    authorize Company
    company = Company.new(company_params)
    return render json: { errors: company.errors, message: "company couldn't be created.", success: false }, status: :unprocessable_entity if !company.save
    render json: { companie: company, message: "company created successfully.", success: true }, status: :created
  end

  def update
    authorize Company
    return render json: { errors: @company.errors, message: "company couldn't be updated successfully.", success: false }, status: :unprocessable_entity if !@company.update(company_params)
    render json: { companie: @company, message: "company updated successfully.", success: true }, status: :ok
  end

  def show
    authorize Company
    render json: { companie: @company, success: true }, status: :ok
  end

  private

  def company_params
    params.require(:company).permit(:name, :rfc, :email, :phone, :city, :number_ext, :number_int, :postal_code, :state, :suburb, :address, :user_id)
  end

  def find_company
    @company = Company.find(params[:id])
  end
end
