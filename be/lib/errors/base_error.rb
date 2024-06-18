module Errors
  class BaseError < StandardError
    attr_reader :code, :message

    def initialize(code: nil, message: nil)
      super
      @message = message
      @code = code
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
