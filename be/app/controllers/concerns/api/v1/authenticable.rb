module Api::V1::Authenticable
  def current_user
    return @current_user if defined? @current_user

    token = request.headers['Authorization']&.split&.last
    return @current_user = nil if token.blank?

    decoded_token = JsonWebToken.decode(token)
    return @current_user = nil unless decoded_token && decoded_token[:email]

    @current_user = find_user_by_email(decoded_token[:email])
  end


  protected

  def check_logged_in!
    raise Errors::Api::Unauthorized, SessionErrorConstant::INVALID_ACCESS_TOKEN unless current_user
  end

  def find_user_by_email(email)
    User.find_by!(email:)
  end
end
