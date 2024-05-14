class Api::V1::SessionsController < ApplicationController
  require 'net/http'
  require 'uri'
  include TokensHelper
  include SessionsHelper

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

  def google_oauth_callback
    gg_service = GoogleAuthService.instance
    gg_user = gg_service.google_user_info(oauth2_params[:access_token])

    unless allowed_email_domain?(gg_user)
      raise Errors::Api::Unauthorized.new(
        code: I18n.t('errors.codes.invalid_email_domain'),
        message: I18n.t('errors.messages.invalid_email_domain')
      )
    end

    user = find_or_create_user(gg_user)
    access_token, refresh_token = generate_tokens_for(user)

    render json: {
      success: true,
      data: {
        access_token:,
        refresh_token:
      }
    }
  end

  private

  def signin_params
    params.permit(:email, :password)
  end

  def oauth2_params
    params.permit(:access_token, :refresh_token)
  end

  def allowed_email_domain?(user_data)
    user_data.key?(:hd) && Settings.gg_oauth.allowed_email_domains.include?(user_data[:hd])
  end

  def find_or_create_user(user_data)
    User.find_or_initialize_by(email: user_data[:email]).tap do |user|
      if user.new_record?
        user.name = user_data[:name]
        user.avatar = user_data[:picture]
        user.save!
      end
    end
  end
end
