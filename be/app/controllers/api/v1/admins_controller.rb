class Api::V1::AdminsController < ApplicationController
  def create
    admin = Admin.new(admin_params)
    admin.save!
    render json: {
      success: true,
      data: {
        email: admin.email,
        name: admin.name
      }
    }, status: :ok

  end

  private

  def admin_params
    params.permit(:email, :password, :name)
  end
end
