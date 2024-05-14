class Api::V1::TokensController < ApplicationController

  def create
    unless signin_params.key?(:email) && signin_params.key?(:password)
      return {
        message: 'Bad request'
      }, status: :bad_request
    end
    user = User.find_by(email: signin_params[:email])
    if user.authenticate(signin_params[:password])
      access_token, refresh_token = generate_tokens_for(user)
      user.update_attribute(:refresh_token, refresh_token)
      render json: {
        userName: user.name,
        accessToken: access_token,
        refreshToken: refresh_token
      }, status: :ok
    else
      render json: {
        message: 'Email or password is incorrect'
      }, status: :unauthorized
    end
  end

  def refresh_token
    return render status: :unauthorized unless cookies[:refresh_token]

    user = User.find_by(refresh_token: cookies[:refresh_token])
    if user && valid_refresh_token?(cookies[:refresh_token], user)
      access_token = JsonWebToken.encode(user_id: user.id)
      render json: { accessToken: access_token }, status: :ok
    else
      render json: { message: 'Invalid refresh token' }, status: :forbidden
    end
  end


  private
  
  def signin_params
    params.permit(:email, :password)
  end

  def generate_tokens_for(user)
    access_token = JsonWebToken.encode(user_id: user.id)
    refresh_token = JsonWebToken.encode({ user_id: user.id }, 7.days.from_now)
    [access_token, refresh_token]
  end

  def valid_refresh_token?(token, user)
    payload = JsonWebToken.decode(token)
    payload[:user_id] == user.id
  rescue
    false
  end
end

