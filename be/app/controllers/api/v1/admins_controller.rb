class Api::V1::AdminsController < ApplicationController
  def create
    admin = Admin.new(admin_params)
    if admin.save
      render json: {
        status: 'success',
        email: admin.email,
        name: admin.name
      }, status: :ok
    else
      render json: {
        status: 'error',
        message: 'Signup failed!',
        errors: admin.errors
      }, status: :unprocessable_entity    
    end
  end

  private

  def admin_params
    params.permit(:email, :password, :name)
  end
end
