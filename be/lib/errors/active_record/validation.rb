module Errors
  module ActiveRecord
    class Validation < Errors::BaseError
      attr_reader :record

      def initialize(record)
        @record = record
        super({code: nil, message: nil})
      end

      def serialize_errors(full_messages: true)
        return unless record

        messages = record.errors.to_hash(full_messages)
        record.errors.details.map do |field, details|
          detail = details.first[:error]
          message = messages[field].first
          {
            resource: translate_resource,
            field: translate_field(field),
            code: translate_code(detail),
            message:
          }
        end
      end

      def translate_resource
        I18n.t(
          @record.class.to_s.underscore, scope: [:errors, :resources], default: @record.class.to_s
        )
      end

      def translate_field(field)
        I18n.t(
          field, scope: [:errors, :resources], default: field.to_s
        )
      end

      def translate_code(detail)
        I18n.t(
          detail, scope: [:errors, :codes], default: detail.to_s
        )
      end
    end
  end
end
