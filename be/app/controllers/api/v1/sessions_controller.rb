class Api::V1::SessionsController < ApplicationController
  require 'net/http'
  require 'uri'
  include TokensHelper
  include SessionsHelper
  before_action :find_user_by_email!, only: [:create]

  def create
    unless @user.authenticate(signin_params[:password])
      raise Errors::Api::Unauthenticated, SessionErrorConstant::AUTHENTICATION_FAILED
    end

    access_token, refresh_token = generate_tokens_for(@user)
    @user.refresh_token = refresh_token
    @user.save!(validate: false)
    render json: {
      success: true,
      data: {
        name: @user.name,
        email: @user.email,
        accessToken: access_token,
        refreshToken: refresh_token
      }
    }, status: :ok
  end

  def refresh_token
    user = User.find_by(refresh_token: params[:refresh_token])
    unless user && valid_refresh_token?(params[:refresh_token], user)
      raise Errors::Api::Unauthenticated, SessionErrorConstant::INVALID_TOKEN
    end

    access_token, = generate_tokens_for(user)
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
      raise Errors::Api::Unauthorized, SessionErrorConstant::NOT_ALLOWED_EMAIL_DOMAIN
    end

    user = find_or_create_user(gg_user)
    access_token, refresh_token = generate_tokens_for(user)
    user.refresh_token = refresh_token
    user.save!(validate: false)

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
        user.picture = user_data[:picture]
        user.password = User.secure_password
        user.save!
      end
    end
  end

  def find_user_by_email!
    @user = User.find_by!(email: params[:email])
  end
end
