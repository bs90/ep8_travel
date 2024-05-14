class JsonWebToken
  SECRET = Rails.application.credentials.secret_key_base

  def self.encode(payload, exp = Settings.token.access_token_exp.to_i.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET).first
    ActiveSupport::HashWithIndifferentAccess.new(decoded)
  rescue JWT::DecodeError => e
    Rails.logger.error("JWT decode error: #{e.message}")
    nil
  end
end
