module Errors::Api
  class Jwt < Errors::BaseError
    attr_reader :message
    def initialize(msg)
      @message = msg
      @code = I18n.t('errors.codes.jwt')
    end

    def serialize_errors
      [
        {code:, message:}
      ]
    end
  end
end
