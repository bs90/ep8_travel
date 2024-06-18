class Api::V1::SessionsController < ApplicationController

  def create
    admin = Admin.find_by!(email: signin_params[:email])
    unless admin.authenticate(signin_params[:password])
      raise Errors::Api::Unauthenticated.new(
        code: I18n.t('errors.codes.unauthenticated'),
        message: I18n.t('errors.messages.unauthenticated')
      )
    end

    access_token, refresh_token = generate_tokens_for(admin)
    admin.refresh_token = refresh_token
    admin.save!(validate: false)
    render json: {
      success: true,
      data: {
        name: admin.name,
        email: admin.email,
        accessToken: access_token,
        refreshToken: refresh_token
      }
    }, status: :ok
  end

  def refresh_token
    user = Admin.find_by(refresh_token: params[:refresh_token])
    unless user && valid_refresh_token?(params[:refresh_token], user)
      raise Errors::Api::Unauthenticated.new(
        code: I18n.t('errors.codes.invalid_token'),
        message: I18n.t('errors.messages.invalid_token')
      )
    end
    access_token = JsonWebToken.encode(user_id: user.id)
    render json: {
      success: true,
      data: {
        accessToken: access_token
      }
    }, status: :ok
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
