module Errors
  class BaseError < StandardError
    attr_reader :error, :code, :message

    def initialize(error)
      @error = error
      @message = error[:message]
      @code = error[:code]
      super(@message)
    end

    def serialize_errors
      [
        {code:, message:}
      ]
    end

    def to_hash
      {
        success: false,
        errors: serialize_errors
      }
    end
  end
end
