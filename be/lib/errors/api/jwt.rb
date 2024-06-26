module Errors::Api
  class Jwt < Errors::BaseError
    attr_reader :message

    def initialize(msg)
      @message = msg
      @code = I18n.t('errors.codes.jwt')
      super({code: @code, message: @message})
    end

    def serialize_errors
      [
        {code:, message:}
      ]
    end
  end
end
