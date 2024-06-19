module Errors
  module Api
    class Unauthorized < Errors::BaseError
      def initialize(code:, message:)
        super(code:, message:)
      end
    end
  end
end
