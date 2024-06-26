class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    user.is_admin = true
    user.save!
    render json: {
      success: true,
      data: {
        email: user.email,
        name: user.name
      }
    }, status: :ok

  end

  private

  def user_params
    params.permit(:email, :password, :name)
  end
end
