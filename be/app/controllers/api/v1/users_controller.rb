class Api::V1::UsersController < ApplicationController
  def create
    user_data = JSON.parse(request.body.read)
    user = User.new(user_params(user_data))
    if user.save
      render json: {
        user: user
      }, status: :ok
    else
      render json: {
        message: 'Signup failed!',
        errors: user.errors
      }, status: :unprocessable_entity
        
    end
  end

  private 

  def user_params(user)
    ActionController::Parameters.new(user).permit(:email, :password, :name)
  end
end
