module Errors::Api
  class Unauthenticated < Errors::BaseError
    attr_reader :resource

    def initialize(error)
      super(error)
      @resource = error[:resource]
    end

    def serialize_errors
      [
        {code:, message:, resource:}
      ]
    end
  end
end
