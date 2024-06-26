module Errors
  module ActiveRecord
    class NotFound < Errors::BaseError
      attr_reader :resource, :field, :detail

      def initialize(error)
        @resource = error.model.underscore
        @field = error.primary_key
        @detail = error.class.to_s.split('::')[1].underscore
        super({code: nil, message: nil})
      end

      def serialize_errors
        [
          {
            resource: I18n.t(resource, scope: [:errors, :resources], default: resource.to_s),
            field:,
            code: I18n.t(detail, scope: [:errors, :codes]),
            message: I18n.t('errors.messages.not_found')
          }
        ]
      end
    end
  end
end
