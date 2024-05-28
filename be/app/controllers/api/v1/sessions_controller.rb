class Api::V1::SessionsController < ApplicationController

  def create
    unless signin_params.key?(:email) && signin_params.key?(:password)
      return {
        status: 'error',
        message: 'Email and password is required'
      }, status: :bad_request
    end
    admin = Admin.find_by(email: signin_params[:email])
    if admin.authenticate(signin_params[:password])
      access_token, refresh_token = generate_tokens_for(admin)
      admin.refresh_token = refresh_token
      if admin.save(validate: false)
        render json: {
          status: 'success',
          name: admin.name,
          email: admin.email,
          accessToken: access_token,
          refreshToken: refresh_token
        }, status: :ok
      else
        render json: {
          status: 'error',
          message: 'Login failed',
          errors: admin.errors
        }, status: :unauthorized
      end
    else
      render json: {
        status: 'error',
        message: 'Email or password is incorrect'
      }, status: :unauthorized
    end
  end

  def refresh_token
    unless cookies[:refresh_token]
      return render json: {
        status: 'error',
        message: 'Refresh token is missing'
      }, status: :unauthorized
    end

    user = Admin.find_by(refresh_token: cookies[:refresh_token])
    if user && valid_refresh_token?(cookies[:refresh_token], user)
      access_token = JsonWebToken.encode(user_id: user.id)
      render json: {
        status: 'success',
        accessToken: access_token
      }, status: :ok
    else
      render json: {
        status: 'error',
        message: 'Invalid refresh token or expired'
      }, status: :forbidden
    end
  end


  private

  def signin_params
    params.permit(:email, :password)
  end

  def generate_tokens_for(user)
    access_token = JsonWebToken.encode({user_id: user.id})
    refresh_token = JsonWebToken.encode({ user_id: user.id },
                                        Settings.token.refresh_token_exp.to_i.days.from_now)
    [access_token, refresh_token]
  end

  def valid_refresh_token?(token, user)
    payload = JsonWebToken.decode(token)
    payload[:user_id] == user.id
  rescue StandardError
    false
  end
end
