class JsonWebToken
  SECRET = Rails.application.credentials.secret_key_base
  ALG = 'HS256'.freeze

  def self.encode(payload, exp = Settings.token.access_token_exp.to_i.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET, ALG)
  end

  def self.decode(token)

    decoded_token = JWT.decode(token, SECRET, true, { algorithm: ALG }).first
      ActiveSupport::HashWithIndifferentAccess.new(decoded_token)

  end
end
