module Errors
  module Api
    class Unauthenticated < Errors::BaseError
      def initialize(code:, message:)
        super(code:, message:)
      end
    end
  end
end
