module TokensHelper
  def generate_tokens_for(user)
    access_token = JsonWebToken.encode({email: user.email})
    refresh_token = JsonWebToken.encode({email: user.email },
                                        Settings.token.refresh_token_exp.to_i.days.from_now)
    [access_token, refresh_token]
  end

  def valid_refresh_token?(token, user)
    payload = JsonWebToken.decode(token)
    payload[:email] == user.email
  rescue StandardError
    false
  end
end
