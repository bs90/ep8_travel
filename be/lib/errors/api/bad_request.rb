module Errors::Api
  class BadRequest < Errors::BaseError
    attr_reader :resource, :field
    def initialize(error)
      super(error)
      @resource = error[:resource]
      @field = error[:field]
    end

    def serialize_errors
      [
        {code:, message:, field:, resource:}
      ]
    end
  end
end
