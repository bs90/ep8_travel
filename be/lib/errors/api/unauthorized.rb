module Errors::Api
  class Unauthorized < Errors::BaseError
    def initialize(error)
      super(error)
    end
  end
end
